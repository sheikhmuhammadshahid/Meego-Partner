import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(65, 20, 90, .1),
  100: Color.fromRGBO(65, 20, 90, .2),
  200: Color.fromRGBO(65, 20, 90, .3),
  300: Color.fromRGBO(65, 20, 90, .4),
  400: Color.fromRGBO(65, 20, 90, .5),
  500: Color.fromRGBO(65, 20, 90, .6),
  600: Color.fromRGBO(65, 20, 90, .7),
  700: Color.fromRGBO(65, 20, 90, .8),
  800: Color.fromRGBO(65, 20, 90, .9),
  900: Color.fromRGBO(65, 20, 90, 1),
};
ThemeData nativeTheme() {
  return ThemeData(
      primaryColor: Color(
          0xFF41145a), //partner app old primary color: #41145a ,new updated color #FFEA00 (02-10-2021)
      // primaryColorLight: Color.fromRGBO(65, 20, 90, .6), // Color(0xFFFFA692),
      primaryColorLight: Color(0x9F41145a),
      primaryColorDark: Color(0xFF41145a),
      primarySwatch: MaterialColor(0xFF41145a, color),
      primaryIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Color(0xFF41145a)),
      cardColor: Color(0xFFF8F1F7),
      primaryTextTheme: TextTheme(
        button: TextStyle(color: Colors.white, fontSize: 17),
        headline1: TextStyle(fontSize: 15, color: Color(0xFF41145a)),
        headline2: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.32), //listtile subtitle white
        headline3: TextStyle(
            fontSize: 21,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5), // intro
        headline4: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black), //service
        headline5: TextStyle(
            fontSize: 13.5,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 0.32,
            fontWeight: FontWeight.w300), // listtile white title
        headline6: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black), //list's title
        subtitle1: TextStyle(
            fontSize: 12.5,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400), // textform label, listtile title
        subtitle2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.6)), //listtile subtitle
        overline: TextStyle(
            fontSize: 31,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7)),
        caption: TextStyle(
            color: Colors.black54,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.32), // drawer

        bodyText1: TextStyle(
            color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(
            color: Colors.black45, fontSize: 10, fontWeight: FontWeight.w400),
      ), //AppBar Text field

      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF41145a),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        padding:
            MaterialStateProperty.all(EdgeInsets.only(top: 10, bottom: 10)),
        backgroundColor: MaterialStateProperty.all(Color(0xFF41145a)),
        shadowColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
        textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        side: MaterialStateProperty.all(
            BorderSide(color: Color(0xFF41145a), width: 1.5)),
        textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 16,
            color: Color(0xFF41145a),
            fontWeight: FontWeight.w400)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
      )),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.grey[100],
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF41145a)),
      ),
      //elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(elevation: 0.5)),
      fontFamily: 'Poppins',
      dividerColor: Colors.grey[300],
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        height: 50,
        buttonColor: Color(0xFF41145a),
        focusColor: Color(0xFF41145a),
        highlightColor: Color(0xFF41145a),
        hoverColor: Color(0xFF41145a),
        splashColor: Color(0xFF41145a),
        disabledColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0))),
      ),
      cardTheme: CardTheme(
        elevation: 0.5,
        margin: EdgeInsets.all(0),
        color: Colors.grey[100],
        shadowColor: Colors.grey[200],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
          // color: Color(0xFF707173),
          fontWeight: FontWeight.w400,
        ),
        counterStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 0.2, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color(0xFF898A8D).withOpacity(0.2)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF41145a)),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.grey[100],
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Color(0xFF41145a), size: 30),
        iconTheme: IconThemeData(color: Color(0xFF41145a), size: 24),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.only(top: 15, bottom: 15),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shadowColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600))),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(Color(0xFF41145a)),
      ));
}
