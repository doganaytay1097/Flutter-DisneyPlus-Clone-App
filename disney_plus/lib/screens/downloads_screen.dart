import 'package:flutter/material.dart';

class DownloadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İndirilenler')),
      body: Center(
        child: Text('İndirilenler Ekranı', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
