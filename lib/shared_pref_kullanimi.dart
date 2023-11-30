import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceKullanimi extends StatefulWidget {
  const SharedPreferenceKullanimi({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceKullanimi> createState() =>
      _SharedPreferenceKullanimiState();
}

class _SharedPreferenceKullanimiState extends State<SharedPreferenceKullanimi> {
  var _secilenCinsiyet = Cinsiyet.KADIN;
  var _secilenRenkler = <String>[];
  var _ogrenciMi = false;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreference Kullanımı'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Adınızı Giriniz'),
            ),
          ),
          for (var item in Cinsiyet.values)
            _buildRadioListTiles(describeEnum(item), item),
          for (var item in Renkler.values) _buildCheckBoxListTiles(item),
          SwitchListTile(
              value: _ogrenciMi,
              title: const Text('Öğrenci Misin ?'),
              onChanged: (bool ogrenciMi) {
                setState(() {
                  _ogrenciMi = ogrenciMi;
                });
              }),
          TextButton(onPressed: _verileriKaydet, child: const Text('Kaydet')),
        ],
      ),
    );
  }

  Widget _buildRadioListTiles(String cinsiyet, Cinsiyet cinsValue) {
    return RadioListTile(
        title: Text(cinsiyet),
        value: cinsValue,
        groupValue: _secilenCinsiyet,
        onChanged: (Cinsiyet? secilmisCinsiyet) {
          setState(() {
            _secilenCinsiyet = secilmisCinsiyet!;
          });
        });
  }

  Widget _buildCheckBoxListTiles(Renkler renk) {
    return CheckboxListTile(
        title: Text(describeEnum(renk)),
        value: _secilenRenkler.contains(describeEnum(renk)),
        onChanged: (bool? deger) {
          if (deger == false) {
            _secilenRenkler.remove(describeEnum(renk));
          } else {
            _secilenRenkler.add(describeEnum(renk));
          }
          setState(() {
            debugPrint(_secilenRenkler.toString());
          });
        });
  }

  void _verileriKaydet() async {
    final name = _nameController.text;

    final preferences = await SharedPreferences.getInstance();

    preferences.setString('isim', name);
    preferences.setBool('ogrenci', _ogrenciMi);
    preferences.setInt('cinsiyet', _secilenCinsiyet.index);
    preferences.setStringList('renkler', _secilenRenkler);
  }

  void _verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    _nameController.text = preferences.getString('isim') ?? '';
    _ogrenciMi = preferences.getBool('ogrenci') ?? false;
    _secilenCinsiyet = Cinsiyet.values[preferences.getInt('cinsiyet') ?? 0];
    _secilenRenkler = preferences.getStringList('renkler') ?? <String>[];
    setState(() {});
  }
}
