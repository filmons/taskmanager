import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/view/auth/auth_page.dart';
import 'package:taskmanager/view/home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _isLoggedIn = user != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text('Task Manager'), 
  backgroundColor: Colors.blue,
  actions: _isLoggedIn ? _buildAppBarActions(FirebaseAuth.instance.currentUser!) : null, 
),

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home_Screen();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }

List<Widget> _buildAppBarActions(User user) {
  return [
    Row(
      children: [
        Icon(Icons.person, color: Colors.white), 
        SizedBox(width: 8), 
        Text(
          user.email ?? '', 
          style: TextStyle(color: Colors.white), 
        ),
      ],
    ),
    IconButton(
      icon: Icon(Icons.logout), 
      onPressed: () {
        FirebaseAuth.instance.signOut();
      },
    ),
  ];
}


}
