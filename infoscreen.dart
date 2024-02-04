import 'package:flutter/material.dart';
import 'package:nazliii/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool evlimi = false;
  TextEditingController isimController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sifreController = TextEditingController();

  String validationMessage = '';

  readStorage() async {
    final SharedPreferences hafiza = await SharedPreferences.getInstance();
    bool? isMarried = hafiza.getBool("evlimi");
    String? isName = hafiza.getString("isim");
    String? userEmail = hafiza.getString("email");
    String? userSifre = hafiza.getString("sifre");

    if (isMarried != null) {
      evlimi = isMarried;
    } else {
      evlimi = false;
    }

    if (isName != null) {
      isimController = TextEditingController(text: isName);
    } else {
      isimController = TextEditingController(text: "");
    }

    if (userEmail != null) {
      emailController = TextEditingController(text: userEmail);
    } else {
      emailController = TextEditingController(text: "");
    }

    if (userSifre != null) {
      sifreController = TextEditingController(text: userSifre);
    } else {
      sifreController = TextEditingController(text: "");
    }

    setState(() {});
  }

  writeStorage() async {
    final SharedPreferences hafiza = await SharedPreferences.getInstance();
    hafiza.setBool("evlimi", evlimi);
    hafiza.setString("isim", isimController.text);
    hafiza.setString("email", emailController.text);
    hafiza.setString("sifre", sifreController.text);
  }

  clearStorage() async {
    final SharedPreferences hafiza = await SharedPreferences.getInstance();
    hafiza.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ekranı"),
        backgroundColor: Color.fromARGB(255, 93, 31, 209),
        actions: [
          InkWell(
            onTap: () {
              if (isimController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  sifreController.text.isNotEmpty) {
                writeStorage();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else {
                setState(() {
                  validationMessage =
                      'Eksik bilgi girdiniz tekrar deneyiniz...';
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.save,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: clearStorage,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete_forever,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SwitchListTile(
                  title: Text("Evli"),
                  value: evlimi,
                  onChanged: (value) {
                    setState(() {
                      evlimi = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: isimController,
                  decoration: InputDecoration(
                    labelText: 'İsim',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: sifreController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (isimController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        sifreController.text.isNotEmpty) {
                      writeStorage();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    } else {
                      setState(() {
                        validationMessage =
                            'Eksik bilgi girdiniz tekrar deneyiniz...';
                      });
                    }
                  },
                  child: Text("Kayıt ol"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Giriş Yap"),
                ),
                SizedBox(height: 16),
                Text(
                  validationMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
