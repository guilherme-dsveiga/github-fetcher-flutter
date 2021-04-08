import 'package:flutter/material.dart';
import 'package:flutter_app/pages/homePage.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/models/defaultColors.dart';
import 'package:flutter_app/models/defaultUser.dart';


class UserDataPage extends StatelessWidget {

   final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<User>(
        future: fetchedGithub,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot){
          if(snapshot.hasData){
            return Scaffold(
              backgroundColor: DefaultColors.secondaryColor,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: DefaultColors.primaryColor,
                title:  Text(
                  snapshot.data!.username
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Container(
                        child: Image(
                          image: NetworkImage(snapshot.data!.profileUrl),
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Container(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              color: DefaultColors.terciaryColor,
                            ),
                            children: [
                              TextSpan(text: 'Usuário: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: snapshot.data!.username),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                child: Column(
                                  children: [
                                    Text('Seguidores:', style: TextStyle(fontSize: 16, fontFamily: 'Roboto', color: DefaultColors.terciaryColor, fontWeight: FontWeight.bold)),
                                    Text(snapshot.data!.followers.toString(), style: TextStyle(fontSize: 16, fontFamily: 'Roboto', color: DefaultColors.terciaryColor)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                child: Column(
                                  children: [
                                    Text('Seguindo:', style: TextStyle(fontSize: 16, fontFamily: 'Roboto', color: DefaultColors.terciaryColor, fontWeight: FontWeight.bold)),
                                    Text(snapshot.data!.followings.toString(), style: TextStyle(fontSize: 16, fontFamily: 'Roboto', color: DefaultColors.terciaryColor))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Container(
                        child:RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              color: DefaultColors.terciaryColor,
                            ),
                            children: [
                              TextSpan(text: 'Criado em: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: formatter.format(DateTime.parse(snapshot.data!.createdAt))),
                            ],
                          ),
                        )
                      ),
                    )
                  ],
                  )
              )
            );
          }
          return Container(
            color: DefaultColors.backgroundErrorColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Usuário não encontrado',
                      style: TextStyle(
                        fontSize: 24,
                        color: DefaultColors.secondaryColor,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: DefaultColors.primaryColor,
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage())
                        );
                      }, 
                      child: Text('Fazer outra busca', style: TextStyle(color: DefaultColors.secondaryColor),),
                    ),
                  )
                ],
              ),
          );
        }
    );
  }
}
