import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter_app/models/defaultUser.dart';
import 'package:flutter_app/models/defaultColors.dart';
import 'package:flutter_app/pages/userDataPage.dart';
import 'package:flutter_app/services/configServices.dart';
var _username, userFetched, uri;

Future<User>? fetchedGithub;

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
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
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserDataPage())));
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: DefaultColors.secondaryColor,
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
                        primary: DefaultColors.primaryColor,
                      ),
                      child: Text(
                        'Pesquisar',
                        style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submit();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Carregando informações...',
                                  style: TextStyle(fontFamily: 'Roboto'))));
                        }
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
