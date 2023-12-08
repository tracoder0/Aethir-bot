import 'package:aseviapp/data/sepet_yemekler.dart';
import 'package:aseviapp/view/checkout.dart';
import 'package:aseviapp/view/cubits/sepetcubit.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

class badgeWidget extends StatelessWidget {
  const badgeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<YemekSepeti> cart = <YemekSepeti>[];
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: badges.Badge(
        badgeContent: BlocBuilder<SepetCubit, List<YemekSepeti>>(
          builder: (context, state) {
            cart = state;
            return Text(state.length.toString());
          },
        ),
        position: badges.BadgePosition.topEnd(top: -20, end: -10),
        showBadge: true,
        ignorePointer: false,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckOutPage(),
              ));
        },
        badgeAnimation: badges.BadgeAnimation.fade(
          animationDuration: Duration(seconds: 1),
          colorChangeAnimationDuration: Duration(seconds: 1),
          loopAnimation: false,
          curve: Curves.fastOutSlowIn,
          colorChangeAnimationCurve: Curves.easeInExpo,
        ),
        child: Icon(
          Icons.shopping_basket_outlined,
          color: Colors.orangeAccent.shade200,
        ),
      ),
    );
  }
}
