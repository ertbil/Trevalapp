import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trevalapp/pages/main_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child :  Travelapp(),));
}

class Travelapp extends StatelessWidget {
const Travelapp({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Student App Demo',
    theme: ThemeData(

      primarySwatch: Colors.blue,
    ),
    home:  const MainPage(),
  );
}
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

