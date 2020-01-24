import 'package:flutter/material.dart';
import 'package:flutter_store/blocs/user_bloc.dart';
import 'package:flutter_store/inherited/bloc_provider.dart';
import 'package:flutter_store/resources/colors.dart';
import 'package:flutter_store/screens/home.dart';
import 'package:flutter_store/screens/login.dart';
import 'package:flutter_store/widgets/logo_widget.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(Duration(seconds: 3));
    final isLogged = await BlocProvider.of<UserBloc>(context).initialize();
    if(!isLogged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Center(
        child: LogoWidget(),
      ),
    );
  }
}
