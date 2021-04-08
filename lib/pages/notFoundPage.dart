import 'package:flutter/material.dart';
import 'package:flutter_app/models/defaultColors.dart';

class NotFoundPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
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
                        Navigator.pushNamed(context, '/');
                      }, 
                      child: Text('Fazer outra busca', style: TextStyle(color: DefaultColors.secondaryColor),),
                    ),
                  )
                ],
              ),
          );
  }
}