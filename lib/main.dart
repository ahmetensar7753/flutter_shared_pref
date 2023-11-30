import 'package:flutter/material.dart';
import 'package:flutter_storage/shared_pref_kullanimi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Storage Kullanimi',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Storage Kullanimi'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SharedPreferenceKullanimi()));
          },
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: const Text('Shared Preference Kullanımı'),
        ),
      ),
    );
  }
}
