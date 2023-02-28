import 'package:fl_test/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

class Logged extends StatelessWidget {
  const Logged({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'logged in',
      initialRoute: '/user_home_page',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

