import 'package:flutter/material.dart';
import 'package:mfqodaty/controller/fb_auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/person_screen');
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: ()async {
                await FbAuthController().signOut();
              Navigator.pushNamed(
                  context, '/login_screen');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
