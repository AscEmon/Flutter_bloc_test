import 'package:bloc_test/mvc/get_module/model/coupon_response.dart';
import 'package:bloc_test/utils/enum.dart';

class GetState {
  GetState({
    this.allGetStatus = AllGetStatus.initial,
    List<CouponData>? couponDataList,
  }) : couponDataList = couponDataList ?? [];


  final AllGetStatus allGetStatus;
  final List<CouponData> couponDataList;

  GetState copyWith({
    AllGetStatus? allGetStatus,
    List<CouponData>? couponDataList,
  }) {
    return GetState(
      couponDataList: couponDataList ?? this.couponDataList,
      allGetStatus: allGetStatus ?? this.allGetStatus,
    );
  }
}

