class CouponResponse {
  CouponResponse({
    this.code,
    this.data,
  });

  int? code;
  List<CouponData>? data;

  factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<CouponData>.from(
                json["data"].map((x) => CouponData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CouponData {
  CouponData({
    this.offerCode,
    this.location,
    this.offerText,
    this.validity,
  });

  String? offerCode;
  String? location;
  String? offerText;
  String? validity;

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
        offerCode: json["offer_code"] == null ? null : json["offer_code"],
        location: json["location"] == null ? null : json["location"],
        offerText: json["offer_text"] == null ? null : json["offer_text"],
        validity: json["validity"] == null ? null : json["validity"],
      );

  Map<String, dynamic> toJson() => {
        "offer_code": offerCode == null ? null : offerCode,
        "location": location == null ? null : location,
        "offer_text": offerText == null ? null : offerText,
        "validity": validity == null ? null : validity,
      };
}