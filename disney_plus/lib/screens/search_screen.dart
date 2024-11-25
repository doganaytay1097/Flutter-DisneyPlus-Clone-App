import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ara')),
      body: Center(child: Text('Arama Ekranı', style: TextStyle(color: Colors.white))),
    );
  }
}
