enum AppUrl {
  Base,
  Coupon,
}

extension AppUrlExtention on AppUrl {
  String get url {
    String _baseUrl = 'http://192.168.0.110:5500/bloc_test/api/';
    switch (this) {
      case AppUrl.Base:
        return "$_baseUrl";
      case AppUrl.Coupon:
        return "coupon.json";
      default:
        return "";
    }
  }
}
