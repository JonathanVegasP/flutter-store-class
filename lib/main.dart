import 'dart:io' show Platform;

import "package:flutter/material.dart";
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_store/blocs/login_bloc.dart';
import 'package:flutter_store/blocs/user_bloc.dart';
import 'package:flutter_store/data/user_data.dart';
import 'package:flutter_store/inherited/bloc_provider.dart';
import 'package:flutter_store/resources/colors.dart';

import 'screens/intro.dart';

class FlutterStore extends StatefulWidget {
  @override
  _FlutterStoreState createState() => _FlutterStoreState();
}

class _FlutterStoreState extends State<FlutterStore> {
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS)
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final user = UserBloc();
    return BlocProvider<UserBloc>(
      bloc: user,
      child: StreamBuilder<UserData>(
        stream: user.outUser,
        builder: (context, snapshot) {
          return MaterialApp(
            title: "Fluter Store",

            theme: ThemeData(
              backgroundColor: BackgroundColor,
              primaryColor: Colors.white,
              hintColor: Colors.white,
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            home: IntroScreen(),
          );
        },
      ),
    );
  }
}

void main() => runApp(FlutterStore());
