import 'package:flutter/material.dart';
import 'package:dori/components/dory_colors.dart';

class DoryThemes {

 static ThemeData get lightTheme => ThemeData(
    fontFamily: 'GmarketSansTTF',
    primarySwatch:  DoryColors.primaryMeterialColor,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.white,
    brightness: Brightness.light, //light
    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
 );
 
 static ThemeData get darkTheme => ThemeData(
    fontFamily: 'GmarketSansTTF',
    primarySwatch:  DoryColors.primaryMeterialColor,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.white,
    brightness: Brightness.dark, //Dark
    textTheme: _textTheme,
 );

 static const AppBarTheme _appBarTheme = AppBarTheme(
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: DoryColors.primaryColor,
    ),
    //경계선 삭제
    //elevation: 0,
 );

  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
  );
}