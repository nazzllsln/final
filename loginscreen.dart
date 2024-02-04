import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode loginFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoginButtonEnabled = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateLoginButtonStatus);
    passwordController.addListener(updateLoginButtonStatus);
  }

  void updateLoginButtonStatus() {
    setState(() {
      isLoginButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  void _performLogin() async {
    SharedPreferences hafiza = await SharedPreferences.getInstance();
    String? storedEmail = hafiza.getString("email");
    String? storedPassword = hafiza.getString("sifre");

    if (emailController.text == storedEmail &&
        passwordController.text == storedPassword) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      setState(() {
        errorMessage = "E-posta veya şifre hatalı.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("E-posta"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 228, 225, 225),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "E-posta adresinizi giriniz...",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Şifre"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 228, 225, 225),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: "Şifrenizi giriniz...",
                    ),
                    obscureText: true,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(loginFocusNode);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      focusNode: loginFocusNode,
                      onPressed: isLoginButtonEnabled ? _performLogin : null,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
