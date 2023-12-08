import 'package:aseviapp/data/repo_sepet.dart';
import 'package:aseviapp/data/sepet_yemekler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SepetCubit extends Cubit<List<YemekSepeti>> {
  SepetCubit() : super(<YemekSepeti>[]);
  var repo = RepoSepet();
  Future<void> getSepet() async {
    var data = await repo.sepetiGetir();
    getTotal();
    emit(data);
  }

  Future<void> getTotal() async {
    await repo.sepetToplam();
  }

  Future<void> addSepet(YemekSepeti yemekSepeti) async {
    await repo.sepeteEkle(yemekSepeti);
    getTotal();
  }

  Future<void> removeSepet(YemekSepeti yemek) async {
    await repo.sepettenSil(yemek.sepet_yemek_id, yemek.kullanici_adi);
    getSepet();
    getTotal();
  }
}
