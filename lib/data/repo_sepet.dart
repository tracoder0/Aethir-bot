import 'dart:convert';

import 'package:aseviapp/data/sepet_yemekler.dart';
import 'package:aseviapp/data/yemeklerresponse.dart';
import 'package:dio/dio.dart';

class RepoSepet {
  var baseUrl = "http://kasimadalan.pe.hu/yemekler/";
  var dio = Dio();

  Future<List<YemekSepeti>> sepetiGetir() async {
    try {
      var url = baseUrl + "sepettekiYemekleriGetir.php";
      var veri = {"kullanici_adi": "baycoder"};
      var response = await dio.post(url, data: FormData.fromMap(veri));
      return SepetResponse.fromJson(jsonDecode(response.toString())).sepet;
    } catch (e) {
      return <YemekSepeti>[];
    }
  }

  Future<void> sepeteEkle(YemekSepeti yemekSepeti) async {
    var guncelSepet = await sepetiGetir();
    var yemek = guncelSepet.firstOrNull?.yemek_adi == yemekSepeti.yemek_adi;

    if (yemek) {
      var y = guncelSepet
          .firstWhere((element) => element.yemek_adi == yemekSepeti.yemek_adi);
      await sepettenSil(y.sepet_yemek_id, yemekSepeti.kullanici_adi);
      yemekSepeti.yemek_siparis_adet += 1;
    }

    var url = baseUrl + "sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": yemekSepeti.yemek_adi,
      "yemek_resim_adi": yemekSepeti.yemek_resim_adi,
      "yemek_fiyat": yemekSepeti.yemek_fiyat,
      "yemek_siparis_adet": yemekSepeti.yemek_siparis_adet,
      "kullanici_adi": "baycoder"
    };
    await dio.post(url, data: FormData.fromMap(veri));
  }

  Future<void> sepettenSil(int yemek_id, String kullanici_adi) async {
    var url = baseUrl + "sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": yemek_id, "kullanici_adi": kullanici_adi};
    await dio.post(url, data: FormData.fromMap(veri));
  }

  Future<int> sepetToplam() async {
    var total = 0;
    var guncelSepet = await sepetiGetir();
    for (YemekSepeti g in guncelSepet) {
      total += g.yemek_fiyat * g.yemek_siparis_adet;
    }

    return total;
  }
}
