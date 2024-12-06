import 'package:disney_plus/screens/main_screen.dart';
import 'package:flutter/material.dart';

class ProfileSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> profiles = [
    {'name': 'Doğanay', 'image': 'https://i.pravatar.cc/300', 'isLocked': true, 'password': '1234'},
    {'name': 'User2', 'image': 'https://i.pravatar.cc/302', 'isLocked': false},
    {'name': 'User3', 'image': 'https://i.pravatar.cc/303', 'isLocked': true, 'password': '5678'},
    {'name': 'User4', 'image': 'https://i.pravatar.cc/304', 'isLocked': false},
  ];

  void _showPasswordDialog(BuildContext context, Map<String, dynamic> profile) {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Şifre Girin'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Şifre'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                if (passwordController.text == profile['password']) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Hatalı şifre!')),
                  );
                }
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff142850),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'PROFİLLERİ DÜZENLE',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Kim İzliyor?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 24,
              ),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return GestureDetector(
                  onTap: () {
                    if (profile['isLocked'] == true) {
                      _showPasswordDialog(context, profile);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(profile['image']!),
                            radius: 45,
                          ),
                          if (profile['isLocked'] == true)
                            Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 25,
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        profile['name']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
