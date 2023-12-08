import 'package:aseviapp/data/sepet_yemekler.dart';
import 'package:aseviapp/data/yemekler.dart';

class YemeklerResponse {
  List<Yemekler> yemekler;
  int success;
  YemeklerResponse({required this.yemekler, required this.success});
  factory YemeklerResponse.fromJson(Map<String, dynamic> json) {
    var _yemekler = json["yemekler"] as List;
    var _success = json["success"] as int;
    var yemekListesi = _yemekler.map((e) => Yemekler.fromJson(e)).toList();
    return YemeklerResponse(yemekler: yemekListesi, success: _success);
  }
}

class SepetResponse {
  List<YemekSepeti> sepet;
  int success;

  SepetResponse({
    required this.sepet,
    required this.success,
  });
  factory SepetResponse.fromJson(Map<String, dynamic> json) {
    var _sepet = json["sepet_yemekler"] as List;
    var _success = json["success"] as int;
    var _sepetListesi = _sepet.map((e) => YemekSepeti.fromJson(e)).toList();
    int getTotal(List<YemekSepeti> yemeksepeti) {
      var total = 0;
      if (yemeksepeti.isNotEmpty) {
        yemeksepeti.forEach((element) {
          total = (element.yemek_fiyat) * (element.yemek_siparis_adet);
        });
      }
      return total;
    }

    return SepetResponse(sepet: _sepetListesi, success: _success);
  }
}
