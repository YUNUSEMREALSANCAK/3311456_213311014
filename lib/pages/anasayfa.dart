import 'package:flutter/material.dart';
import 'package:mobilprogramlamauyg/pages/ayarlar.dart';
import 'package:mobilprogramlamauyg/pages/borsa.dart';
import 'package:mobilprogramlamauyg/pages/graph.dart';
import 'package:mobilprogramlamauyg/pages/notlar.dart';
import 'package:mobilprogramlamauyg/mywidget/bottom_navigator_witget.dart';
import '/mywidget/anasayfa_giderler_bas_widget.dart';
class anasayfa extends StatefulWidget {
  const anasayfa({Key? key}) : super(key: key);

  @override
  State<anasayfa> createState() => _anasayfaState();
}

class _anasayfaState extends State<anasayfa> {
  double _butcetutari = 0.0;
  String _gideradi = "";
  double _gidertutari = 0.0;
  List<Map<String, dynamic>> _giderler = [];

  void butceeklemesayfasi() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Bütçe Ekle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Bütçe Miktarı",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    _butcetutari = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Ekle"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void gidereklemesayfasi() {
    bool expenseAdded = false;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Harcama Ekle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Harcama Adı",
                ),
                onChanged: (value) {
                  setState(() {
                    _gideradi = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Harcama Miktarı",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    _gidertutari = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Ekle"),
              onPressed: () {
                _giderler.add({
                  "isim": _gideradi,
                  "tutar": _gidertutari,
                });
                expenseAdded = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      if (expenseAdded) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:  Colors.amber,
          title: Center(child: Text("GİDER TAKİP SAYFASI")
          )
      ),
      backgroundColor: Color(0xFFFFE082),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              'Bütçe: $_butcetutari TL',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  tooltip: 'BÜTÇE EKLE',
                  backgroundColor: Colors.amber.shade400,//white
                  splashColor: Colors.blueGrey,
                  onPressed: butceeklemesayfasi,
                  child: Icon(Icons.add,color: Colors.white70,),
                ),
              )
            ],
          ),
          Giderleri_bas(giderler:_giderler ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyNavigatorContainer(
                sayfaAdi: "NOTLAR",
                yonlendir: NotePage(),
              ),
              MyNavigatorContainer(
                sayfaAdi: "GRAFİK",
                yonlendir: graphpage(),
              ),
              MyNavigatorContainer(
                sayfaAdi: "BORSA",
                yonlendir: borsapage(),
              ),
              MyNavigatorContainer(
                sayfaAdi: "AYARLAR",
                yonlendir: ayarlarpage(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30,top: 30,right: 2,bottom: 60),
        child: FloatingActionButton(
          tooltip: 'GİDER EKLE',
          backgroundColor: Colors.amber.shade400,
          splashColor: Colors.blueGrey,
          onPressed: gidereklemesayfasi,
          child: Icon(Icons.add ,color:Colors.white70),
        ),
      ),
    );
  }
}



