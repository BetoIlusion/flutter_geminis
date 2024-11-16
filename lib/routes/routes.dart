import 'package:flutter/material.dart';
import 'package:flutter_geminis/screen/TareaScreen.dart';

class Routes{
  static const String HOME = '/';
}

Map<String, WidgetBuilder> GetRoutes(){
  return <String, WidgetBuilder>{
    Routes.HOME : (BuildContext context) => const TareaScreen(),
    
  };
}