import 'package:aseviapp/data/sepet_yemekler.dart';
import 'package:aseviapp/data/yemekler.dart';
import 'package:aseviapp/view/components/badgeWidget.dart';
import 'package:aseviapp/view/cubits/sepetcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Detail extends StatefulWidget {
  Yemekler item;
  int count = 1;
  Detail({required this.item});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Widget customMenuItem(var img, var text, var price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 300.0,
            child: Row(
              children: <Widget>[
                Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xffFFE4E0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(fit: BoxFit.cover, image: NetworkImage(img)),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                            letterSpacing: 0.75,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.orange, size: 17),
                          Icon(Icons.star, color: Colors.orange, size: 17),
                          Icon(Icons.star, color: Colors.orange, size: 17),
                          Icon(Icons.star, color: Colors.orange, size: 17),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "$price ₺",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "499",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Image.asset(
                    "images/logo.png",
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                badgeWidget()
              ],
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              widget.item.yemek_adi.toUpperCase(),
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            height: 28.0,
          ),
          Container(
            height: 280.0,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "http://kasimadalan.pe.hu/yemekler/resimler/${widget.item.yemek_resim_adi}"),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.orangeAccent,
                              ),
                              onPressed: () {}),
                        ),
                        Card(
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.orange.shade900,
                              ),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "${widget.item.yemek_fiyat.toString()} ₺",
                  style: TextStyle(
                    fontSize: 38.0,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: 82,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                  color: const Color.fromRGBO(221, 44, 0, 1),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 55,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.remove),
                                color: Colors.orange,
                                onPressed: () {
                                  if (widget.count > 0) {
                                    setState(() {
                                      widget.count = widget.count - 1;
                                    });
                                  }
                                }),
                            Text(
                              "${widget.count}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.deepOrange,
                                onPressed: () {
                                  if (widget.count >= 0) {
                                    setState(() {
                                      widget.count = widget.count + 1;
                                    });
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<SepetCubit>().addSepet(YemekSepeti(
                            sepet_yemek_id: 0,
                            yemek_adi: widget.item.yemek_adi,
                            yemek_resim_adi: widget.item.yemek_resim_adi,
                            yemek_fiyat: widget.item.yemek_fiyat,
                            yemek_siparis_adet: widget.count,
                            kullanici_adi: "baycoder"));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent.shade700,
                          content:
                              Text("${widget.item.yemek_adi} sepete eklendi."),
                        ));
                        context.read<SepetCubit>().getSepet();
                      },
                      child: Text(
                        "Ekle",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 28.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Belki İlginizi Çekebilir",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.75,
              ),
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          customMenuItem(
              "http://kasimadalan.pe.hu/yemekler/resimler/${widget.item.yemek_resim_adi}",
              "${widget.item.yemek_adi}",
              "112"),
          customMenuItem(
              "http://kasimadalan.pe.hu/yemekler/resimler/${widget.item.yemek_resim_adi}",
              "${widget.item.yemek_adi}",
              "248"),
          customMenuItem(
              "http://kasimadalan.pe.hu/yemekler/resimler/${widget.item.yemek_resim_adi}",
              "${widget.item.yemek_adi}",
              "420"),
          customMenuItem(
              "http://kasimadalan.pe.hu/yemekler/resimler/${widget.item.yemek_resim_adi}",
              "${widget.item.yemek_adi}",
              "12"),
        ],
      ),
    );
  }
}
