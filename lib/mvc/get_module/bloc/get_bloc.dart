import 'package:bloc_test/constant/app_url.dart';
import 'package:bloc_test/data_provider/api_client.dart';
import 'package:bloc_test/mvc/get_module/bloc/get_event.dart';
import 'package:bloc_test/mvc/get_module/bloc/get_state.dart';
import 'package:bloc_test/mvc/get_module/model/coupon_response.dart';
import 'package:bloc_test/utils/enum.dart';
import 'package:bloc_test/utils/extention.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetBloc extends Bloc<GetEvent, GetState> {
  final ApiClient apiClient = ApiClient();
  GetBloc() : super(GetState()) {
    on<GainedEvent>(_fetchCupon);
  }

  void _fetchCupon(GainedEvent event, Emitter<GetState> emit) async {
    emit(state.copyWith(allGetStatus: AllGetStatus.loading));
    try {
      await apiClient.request(
        method: Method.GET,
        url: AppUrl.Coupon.url,
        onSuccessFunction: (Response result) {
          if (result.data != null) {
            var data = CouponResponse.fromJson(result.data);
            if (data.code == 200) {
              if (data.data != null) {
                emit(
                  state.copyWith(
                    allGetStatus: AllGetStatus.success,
                    couponDataList: data.data ?? [],
                  ),
                );
                "Length is ".log();
                data.data?.length.log();
              }
            }
          }
        },
      );
    } on Exception catch (e) {
      e.log();
      emit(state.copyWith(allGetStatus: AllGetStatus.error));
    }
  }
}
