import 'package:aseviapp/data/repo_yemekler.dart';
import 'package:aseviapp/data/yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<List<Yemekler>> {
  HomeCubit() : super(<Yemekler>[]);
  var repo = RepoYemekler();
  Future<void> tumYemekleriGetir() async {
    var yemekler = await repo.yemekleriGetir();
    emit(yemekler);
  }
}
