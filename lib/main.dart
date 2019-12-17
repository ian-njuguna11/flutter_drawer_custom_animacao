import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Bloc/configuracao_bloc.dart';
import 'Login/splash_screen.dart';
import 'Utils/rech_theme.dart';

final ThemeData kAndroidTheme = ThemeData(
  primaryColor: Color.fromRGBO(109, 172, 238, 1.0),
  primaryIconTheme: IconThemeData(color: Colors.white),
  primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
);

final ThemeData kRechTheme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: RechTheme.textTheme,
  platform: TargetPlatform.iOS,
);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.grey,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(BlocProvider(
    blocs: [
      Bloc((i) => ConfiguracaoBloc()),
    ],
    child: MaterialApp(
      title: "Teste Estrutura",
      home: SplashScreen(),
      theme: kRechTheme,
      debugShowCheckedModeBanner: false,
    ),
  ));
}
