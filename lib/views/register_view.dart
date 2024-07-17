import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_options.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    obscureText: false,
                    enableSuggestions: true,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                    ),
                  ),
                  TextButton(
                      onPressed: () async {

                        final email = _email.text;
                        final password = _password.text;

                        try{ final userCredential =
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email,
                            password: password);

                        print(userCredential);
                        } on FirebaseAuthException catch (e){
                          if(e.code == 'weak-password'){
                            print('WEAK PASSWORD');
                          }
                          else if(e.code == 'email-already-in-use'){
                            print('EMAIL ALREADY IN USE');
                          }
                          else if(e.code == 'invalid-email'){
                            print('INCORRECT EMAIL');
                          }
                        }
                      },
                      child: const Text("register")
                  ),
                ],
              );
            default:
              return const Text("loading...");
          }
        },
      ),
    );
  }

}