import 'package:aseviapp/data/sepet_yemekler.dart';
import 'package:aseviapp/data/yemekler.dart';
import 'package:aseviapp/view/components/badgeWidget.dart';
import 'package:aseviapp/view/cubits/homecubit.dart';
import 'package:aseviapp/view/cubits/sepetcubit.dart';
import 'package:aseviapp/view/detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(10)));

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().tumYemekleriGetir();
    context.read<SepetCubit>().getSepet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            backgroundColor: Colors.orangeAccent.shade400,
            pinned: true,
            floating: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 0),
              background: CarouselSlider(
                options: CarouselOptions(height: 240.0, autoPlay: true),
                items: ["1.jpeg", "2.jpg", "3.jpg"].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration:
                            BoxDecoration(color: Colors.orangeAccent.shade200),
                        child: Image.asset(
                          'images/kampanya/$i',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            bottom: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  "images/logo.png",
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_sharp,
                            color: Colors.orangeAccent.shade700,
                          )),
                    ),
                    badgeWidget()
                  ],
                )
              ],
              centerTitle: true,
            ),
          ),
          //3
          BlocBuilder<HomeCubit, List<Yemekler>>(
            builder: (context, getYemekler) {
              if (getYemekler.isNotEmpty) {
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var item = getYemekler[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail(item: item),
                              ));
                        },
                        child: Card(
                          semanticContainer: true,
                          // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // Set the clip behavior of the card
                          clipBehavior: Clip.antiAliasWithSaveLayer,

                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Image.network(
                                    "http://kasimadalan.pe.hu/yemekler/resimler/${item.yemek_resim_adi}",
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Text(
                                  item.yemek_adi,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${item.yemek_fiyat.toString()} ₺",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.add_box_rounded,
                                          color: const Color.fromRGBO(
                                              221, 44, 0, 1),
                                        ),
                                        onPressed: () {
                                          context.read<SepetCubit>().addSepet(
                                              YemekSepeti(
                                                  sepet_yemek_id: 0,
                                                  yemek_adi: item.yemek_adi,
                                                  yemek_resim_adi:
                                                      item.yemek_resim_adi,
                                                  yemek_fiyat: item.yemek_fiyat,
                                                  yemek_siparis_adet: 1,
                                                  kullanici_adi: "baycoder"));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor:
                                                Colors.orangeAccent.shade700,
                                            content: Text(
                                                "${item.yemek_adi} sepete eklendi."),
                                          ));
                                          context.read<SepetCubit>().getSepet();
                                        }),
                                  ], //AddTo Box
                                ),
                              ]),
                        ),
                      );
                    },
                    childCount: getYemekler.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                    child: Center(
                      child: Text("Buralar Çok Sessiz"),
                    ),
                  ),
                );
              }
            },
          ),

          //newMethod()
        ],
      ),
    );
  }
}
