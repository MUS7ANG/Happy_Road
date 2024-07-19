import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/views/email_verify_view.dart';
import 'package:flutter_app/views/login_view.dart';
import 'package:flutter_app/views/register_view.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
        title: 'Home Page',
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
    ),
        home: const HomePage(),
        routes:{
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
         '/happy/': (context) => const HappyRoad(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.active) {
                  final user = userSnapshot.data;
                  if (user != null) {
                    if (user.emailVerified) {
                      return const HappyRoad();
                    } else {
                      return const EmailVerificationView();
                    }
                  } else {
                    return const LoginView();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction {
  logout
}

class HappyRoad extends StatefulWidget {
  const HappyRoad({super.key});

  @override
  State<HappyRoad> createState() => _HappyRoadState();
}

class _HappyRoadState extends State<HappyRoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value){
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDiolog(context);
                  if(shouldLogout){
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login/',
                        (_) => false,
                    );
                  }
            }},
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  }
}



Future<bool> showLogOutDiolog(BuildContext context){
  return showDialog<bool>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('sign out'),
          content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop(false);
          },
              child: const Text('Cancel')),
          TextButton(onPressed: (){
            Navigator.of(context).pop(true);
          },
              child: const Text('Log out')),
        ],
        );
  }
  ).then((value) => value ?? false);
}









