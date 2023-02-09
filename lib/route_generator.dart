import 'package:fl_test/login.dart';
import 'package:fl_test/user_home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/user_home_page':
      if(args is String){
        return MaterialPageRoute(builder: ((context) => UserHomePage(title: args)));
      }else{
        return MaterialPageRoute(builder: ((context) => const UserHomePage(title: "AhHhHhAHAHAHHAHA")));
      }
      break;
      case '/login':
        return MaterialPageRoute(builder: ((context) => Login(title: "Login")));
      break;
      default: 
      return MaterialPageRoute(builder: ((context) => const Login(title: "NOT IT!!!")));
    }
  }
}