import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
void main() {
  Gemini.init(apiKey: 'APY KEY');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      routes: GetRoutes(),
      initialRoute: '/',
    );
  }
}
