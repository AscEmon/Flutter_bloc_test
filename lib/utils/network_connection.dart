import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:bloc_test/utils/enum.dart';
import 'package:bloc_test/utils/view_util.dart';


class NetworkConnection {
  static NetworkConnection? _instance;

  NetworkConnection._();

  static NetworkConnection get instance => _instance ??= NetworkConnection._();
  bool isInternet = true;

  InternetAvailable() async {
    StreamSubscription<ConnectivityResult> subscription;

    subscription = await Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.none) {
        isInternet = false;
        ViewUtil.SSLSnackbar("Internet is not Available");
      } else {
        isInternet = true;
      }
    });
  }

  List<APIParams> apiStack = [];
}

//check api params for calling the api while internet will be available
class APIParams {
  String url;
  Method method;
  Map<String, dynamic> variables;
  Function? Function(Response<dynamic>)? onSuccessFunction;

  APIParams(
      {required this.url,
      required this.method,
      required this.variables,
      required this.onSuccessFunction});
}

