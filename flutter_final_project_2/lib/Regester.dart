// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'MyClasses.dart';

class Regester extends StatefulWidget {
  const Regester({super.key});

  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  // ignore: non_constant_identifier_names
  Future SignUp() async {
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/');
  }

  String errorString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Welcome to AGH Movies"),
          elevation: 0,
          // leading: const Icon(Icons.menu, color: Colors.deepPurpleAccent),
        ),
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Container(
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 10),
                            child: TextInput(
                              PlaceHolder: "Email",
                              TextControler: _emailController,
                              InputType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 10),
                            child: TextInput(
                                PlaceHolder: "Password",
                                TextControler: _passwordController,
                                InputType: TextInputType.visiblePassword),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 10),
                            child: TextInput(
                              PlaceHolder: "Confirm Password",
                              TextControler: _confirmPasswordController,
                              InputType: TextInputType.visiblePassword,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 10),
                            child: MyButton(
                              Lable: "Create Account",
                              OnClick: () {
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailController.text.trim())) {
                                  setState(() {
                                    errorString =
                                        "Email must be in an email format";
                                  });
                                } else if (_passwordController.text.trim() !=
                                    _confirmPasswordController.text.trim()) {
                                  setState(() {
                                    errorString =
                                        "Password must be like Confirm Password";
                                  });
                                } else if (_passwordController.text
                                        .trim()
                                        .length <
                                    6) {
                                  setState(() {
                                    errorString =
                                        "Password must be Grater than 5 chracters";
                                  });
                                } else {
                                  try {
                                    SignUp();
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      errorString = "Invalid Input: ${e.code}";
                                    });
                                  }
                                }
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
                                  "Algready have an account?",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: const Text(
                                  "Login",
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
                              errorString,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 18),
                            ),
                          )
                        ],
                      )),
                ))));
  }
}
