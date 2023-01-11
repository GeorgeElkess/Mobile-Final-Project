// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MyClasses.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  Future<String> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      } else {
        return "Invalid Login";
      }
    }
    return "Good";
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  String ErrorString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Login"),
        // leading: const Icon(Icons.menu, color: Colors.deepPurpleAccent),
      ),
      body: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/pngegg_(3).png',
                width: 187.6,
                height: 172,
                fit: BoxFit.contain,
              ),
              Padding(
                padding:const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: TextInput(
                  PlaceHolder: "Email",
                  TextControler: _emailController,
                  InputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: TextInput(
                  PlaceHolder: "Password",
                  TextControler: _passwordController,
                  InputType: TextInputType.visiblePassword,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: MyButton(
                  Lable: "Login",
                  OnClick: () async {
                    ErrorString = await signIn();
                    setState(() {});
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Regester');
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  ErrorString,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              )
            ],
          )),
    );
  }
}
