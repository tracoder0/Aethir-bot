import 'dart:convert';

import 'package:aseviapp/data/yemekler.dart';
import 'package:aseviapp/data/yemeklerresponse.dart';
import 'package:dio/dio.dart';

class RepoYemekler {
  var baseUrl = "http://kasimadalan.pe.hu/yemekler/";
  var dio = Dio();
  Future<List<Yemekler>> yemekleriGetir() async {
    var response = await dio.get(baseUrl + "tumYemekleriGetir.php");
    return YemeklerResponse.fromJson(jsonDecode(response.toString())).yemekler;
  }
}
