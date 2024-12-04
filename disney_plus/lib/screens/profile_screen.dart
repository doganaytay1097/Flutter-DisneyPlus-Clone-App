import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<Map<String, String>> profiles = [
    {'name': 'Doğanay', 'image': 'https://i.pravatar.cc/300'},
    {'name': 'User2', 'image': 'https://i.pravatar.cc/302'},
    {'name': 'User3', 'image': 'https://i.pravatar.cc/303'},
    {'name': 'User4', 'image': 'https://i.pravatar.cc/304'},
  ];

  final List<String> settings = [
    'İzleme Listem',
    'Uygulama Ayarları',
    'Hesap',
    'Yasal',
    'Yardım',
    'Oturumu Kapat',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Color(0xff142850),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(profile['image']!),
                        radius: 35,
                      ),
                      SizedBox(height: 8),
                      Text(
                        profile['name']!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[850],
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'PROFİLLERİ DÜZENLE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: settings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    settings[index],
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Sürüm: 3.10.0-rc4-2024.11.15 (173170946)',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
