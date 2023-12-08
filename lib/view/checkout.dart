import 'dart:ui';

import 'package:aseviapp/constants.dart';
import 'package:aseviapp/view/cubits/homecubit.dart';
import 'package:aseviapp/view/cubits/sepetcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:aseviapp/data/sepet_yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key? key});

  double oldTotal = 0;
  double total = 0;
  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage>
    with SingleTickerProviderStateMixin {
  double oldTotal = 0;
  double total = 0;
  var carts = <YemekSepeti>[];
  ScrollController scrollController = ScrollController();
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..forward();
    context.read<SepetCubit>().getSepet();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Sepet'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...buildHeader(),
              BlocBuilder<SepetCubit, List<YemekSepeti>>(
                  builder: (context, getsepet) {
                oldTotal = total;
                total = 0;
                if (getsepet.isNotEmpty) {
                  carts = getsepet;
                  return ListView.builder(
                      itemCount: carts.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        total += carts[index].yemek_fiyat *
                            carts[index].yemek_siparis_adet;
                        return buildCartItemList(carts[index]);
                      });
                } else {
                  return Center(
                    child: Text("Buralar sessiz. Hadi Alışverişe başlayalım"),
                  );
                }
              }),
              //cart items list

              SizedBox(height: 16),
              Divider(),
              buildPriceInfo(),
              //checkoutButton(cart, context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildHeader() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Text('Seçilen Ürünler', style: headerStyle),
      ),
    ];
  }

  Widget buildPriceInfo() {
    oldTotal = total;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Toplam:', style: headerStyle),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Text(
                '\ ${lerpDouble(oldTotal, total, animationController.value)?.toStringAsFixed(2)} ₺',
                style: headerStyle);
          },
        ),
      ],
    );
  }

  Widget buildCartItemList(YemekSepeti item) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        height: 100,
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${item.yemek_resim_adi}",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 45,
                    child: Text(
                      "${item.yemek_adi} (${item.yemek_fiyat} ₺)",
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        customBorder: roundedRectangle4,
                        onTap: () {
                          //cart.decreaseItem(cartModel);
                          animationController.reset();
                          animationController.forward();
                        },
                        child: Icon(Icons.remove_circle),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                        child: Text('${item.yemek_siparis_adet}',
                            style: titleStyle),
                      ),
                      InkWell(
                        customBorder: roundedRectangle4,
                        onTap: () {
                          // cart.increaseItem(cartModel);
                          animationController.reset();
                          animationController.forward();
                        },
                        child: Icon(Icons.add_circle),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 70,
                    child: Text(
                      '\ ${item.yemek_fiyat * item.yemek_siparis_adet} ₺',
                      style: titleStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<SepetCubit>()
                          .removeSepet(item)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent.shade700,
                          content: Text("${item.yemek_adi} sepetten silindi."),
                        ));
                      });
                      //cart.removeAllInCart(cartModel.food);
                      animationController.reset();
                      animationController.forward();
                    },
                    customBorder: roundedRectangle12,
                    child: Icon(Icons.delete_sweep, color: Colors.red),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
