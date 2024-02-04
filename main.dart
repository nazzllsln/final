import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nazliii/model/loadData.dart';
import 'package:http/http.dart' as http;
import 'package:nazliii/screens/homescreen.dart';
import 'package:nazliii/screens/loginscreen.dart';
import 'package:nazliii/screens/profilescreen.dart';
import 'package:nazliii/widgets/infoscreen.dart';

void main() {
  runApp(const MyApp());
}

Future<LoadData> apiCall() async {
  final response = await http
      .get(Uri.parse('https://github.com/nazzllsln/mobilprogramlama.git'));

  if (response.statusCode == 200) {
    return LoadData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Bir hata oluştu');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/info': (context) => InfoScreen(),
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          '/profile': (context) => ProfileScreen(),
        },
        home: InfoScreen()
        /*Scaffold(
        body: FutureBuilder<LoadData>(
          future: apiCall(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: Text(
                    'Kullanıcı Adı: ${snapshot.data!.username}\nE-Posta: ${snapshot.data!.email}',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('yüklenemedi'),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        
      ),*/
        );
  }
}
