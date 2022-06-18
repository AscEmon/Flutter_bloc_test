import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/constant/app_url.dart';
import 'package:bloc_test/constant/constant_key.dart';
import 'package:bloc_test/data_provider/pref_helper.dart';
import 'package:bloc_test/utils/enum.dart';
import 'package:bloc_test/utils/extention.dart';
import 'package:bloc_test/utils/navigation_service.dart';
import 'package:bloc_test/utils/network_connection.dart';
import 'package:bloc_test/utils/view_util.dart';

class ApiClient {
  late Dio _dio;

  Map<String, dynamic> _header = {};

  _initDio() {
    _header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${PrefHelper.getString(TOKEN)}"
    };

    _dio = Dio(BaseOptions(
      baseUrl: AppUrl.Base.url,
      headers: _header,
      connectTimeout: 1000 * 30,
      sendTimeout: 1000 * 10,
    ));
    _initInterceptors();
  }

  void _initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print(
          'REQUEST[${options.method}] => PATH: ${AppUrl.Base.url}${options.path} '
          '=> Request Values: param: ${options.queryParameters}, DATA: ${options.data}, => HEADERS: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      print(
          'RESPONSE[${response.statusCode}] => DATA: ${response.data} URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      return handler.next(response);
    }, onError: (err, handler) {
      print(
          'ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data} Message: ${err.message} URL: ${err.response?.requestOptions.baseUrl}${err.response?.requestOptions.path}');
      return handler.next(err);
    }));
  }

  // Image or file upload using Rest handle.
  Future requestFormData(String url, Method method,
      Map<String, dynamic>? params, Map<String, File>? files) async {
    _header[Headers.contentTypeHeader] = 'multipart/form-data';
    _initDio();

    Map<String, MultipartFile> fileMap = {};
    if (files != null) {
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        fileMap[fileEntry.key] = await MultipartFile.fromFile(file.path);
      }
    }
    params?.addAll(fileMap);
    final data = FormData.fromMap(params!);

    print(data.fields.toString());
    // Handle and check all the status.
    return clientHandle(url, method, params, data: data);
  }

  // Normal Rest API  handle.
  Future request(
      {required String url,
      required Method method,
      Map<String, dynamic>? params,
      Function? onSuccessFunction(Response response)?}) async {
    if (NetworkConnection.instance.isInternet) {
      _initDio();
      // Handle and check all the status.
      return clientHandle(url, method, params,
          onSuccessFunction: onSuccessFunction);
    } else {
      NetworkConnection.instance.apiStack.add(APIParams(
          url: url,
          method: method,
          variables: params ?? {},
          onSuccessFunction: onSuccessFunction));
      if (ViewUtil.isPresentedDialog == false) {
        ViewUtil.isPresentedDialog = true;
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ViewUtil.showInternetDialog(onPressed: () {
            if (NetworkConnection.instance.isInternet == true) {
              Navigator.of(Navigation.key.currentState!.overlay!.context,
                      rootNavigator: true)
                  .pop();
              ViewUtil.isPresentedDialog = false;
              NetworkConnection.instance.apiStack.forEach((element) {
                request(
                    url: element.url,
                    method: element.method,
                    params: element.variables,
                    onSuccessFunction: element.onSuccessFunction);
              });
              NetworkConnection.instance.apiStack = [];
            }
          });
        });
      }
    }
  }

// Handle all the method and error.
  Future clientHandle(String url, Method method, Map<String, dynamic>? params,
      {dynamic data, Function? onSuccessFunction(Response response)?}) async {
    Response response;
    try {
      // Handle response code from api.
      if (method == Method.POST) {
        response = await _dio.post(url, queryParameters: params, data: data);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }
      /**
       * Handle Rest based on response json
       * So please check in json body there is any status_code or code
       */
      if (response.statusCode == 200) {
        final Map data = json.decode(response.toString());

        final code = data['code'];
        if (code == 200) {
          return onSuccessFunction!(response);
        } else {
          if (code < 500) {
            List<String> messages = data['message'].cast<String>();

            switch (code) {
              case 401:
                // PrefHelper.setString(TOKEN, "").then((value) => LoginScreen()
                //     .pushAndRemoveUntil(Navigation.key.currentContext));

                break;
              default:
                ViewUtil.SSLSnackbar(_extractMessages(messages));

                throw Exception(_extractMessages(messages));
            }
          } else {
            ViewUtil.SSLSnackbar("Server Error");
            throw Exception();
          }
        }
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something went wrongs");
      }

      // Handle Error type if dio catches anything.
    } on DioError catch (e) {
      e.log();
      switch (e.type) {
        case DioErrorType.connectTimeout:
          ViewUtil.SSLSnackbar("Time out delay ");
          break;
        case DioErrorType.receiveTimeout:
          ViewUtil.SSLSnackbar("Server is not responded properly");
          break;
        case DioErrorType.other:
          if (e.error is SocketException) {
            ViewUtil.SSLSnackbar("Check your Internet Connection");
          }
          break;
        case DioErrorType.response:
          try {
            ViewUtil.SSLSnackbar("Internal Responses error");
          } catch (e) {
          } finally {
            throw Exception(e.toString());
          }

        default:
      }
    } catch (e) {
      "ex".log();
      e.log();
      throw Exception("Something went wrong" + e.toString());
    }
  }

  /**
   * error message will give us as a list of string thats why extract it
   * so check it in your response
   */
  _extractMessages(List<String> messages) {
    var str = "";

    messages.forEach((element) {
      str += element;
    });

    return str;
  }
}


