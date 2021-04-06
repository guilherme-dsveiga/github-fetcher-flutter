import 'package:flutter/material.dart';
import 'package:flutter_app/secondRoute.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/services.dart';

var _username, userFetched, uri;

Future<User>? fetchedGithub;

Color primaryColor = const Color.fromRGBO(192, 96, 20, 1);
Color secondaryColor = const Color.fromRGBO(243, 244, 237, 1);
Color terciaryColor = const Color.fromRGBO(66, 70, 66, 1);
Color backgroundErrorColor = const Color.fromRGBO(83, 97, 98, 1);

void main() => {
   SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
  runApp(App())
};

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        backgroundColor: secondaryColor,
      ),
      home: Scaffold(
        body: SubmitForm(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class User {
  User(
      {required this.profileUrl,
      required this.username,
      required this.followers,
      required this.followings,
      required this.createdAt});

  final String profileUrl, username, createdAt;
  final int followers, followings;

  factory User.fromJson(Map<String, dynamic> json) => User(
        profileUrl: json['avatar_url'],
        username: json['login'],
        followers: json['followers'],
        followings: json['following'],
        createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() => {
        'avatar_url': profileUrl,
        'login': username,
        'followers': followers,
        'followings': followings,
        'created_at': createdAt,
      };
}

// Create a Form widget.
class SubmitForm extends StatefulWidget {
  @override
  SubmitFormState createState() {
    return SubmitFormState();
  }
}

class SubmitFormState extends State<SubmitForm> {
  final _formKey = GlobalKey<FormState>();

  Future<User> fetchGithub() async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.get(uri);
      userFetched = User.fromJson(response.data);
      return userFetched;
    } on DioError catch (err) {
      throw ('Erro ao realizar o metodo GET - $err');
    }
  }

  void submit() {
    _formKey.currentState!.save();
    uri = 'https://api.github.com/users/' + _username;
    fetchedGithub = fetchGithub();
    Timer(
        Duration(seconds: 2),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SecondRoute())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      child: Center(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: 500,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'Roboto'),
                      decoration: InputDecoration(
                        labelText: 'Nome de Usuário',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Escreva algo!';
                        }
                        return null;
                      },
                      onSaved: (input) => _username = input,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                    ),
                    child: Text(
                      'Pesquisar',
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        submit();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Carregando...',
                                style: TextStyle(fontFamily: 'Roboto'))));
                      }
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
