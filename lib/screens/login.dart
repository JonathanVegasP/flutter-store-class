import 'package:flutter/material.dart';
import 'package:flutter_store/blocs/login_bloc.dart';
import 'package:flutter_store/blocs/user_bloc.dart';
import 'package:flutter_store/inherited/bloc_provider.dart';
import 'package:flutter_store/resources/colors.dart';
import 'package:flutter_store/screens/home.dart';
import 'package:flutter_store/widgets/logo_widget.dart';
import 'package:flutter_store/widgets/vollup_logo.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LogoWidget(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              StreamBuilder<String>(
                                stream: _bloc.outEmail,
                                builder: (context, snapshot) {
                                  return TextField(
                                    decoration: InputDecoration(
                                      labelText: "Digite o seu usuario",
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: snapshot.hasError
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                      errorText: snapshot.error,
                                    ),
                                    onChanged: _bloc.inEmail,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              StreamBuilder<String>(
                                stream: _bloc.outPassword,
                                builder: (context, snapshot) {
                                  return TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      errorText: snapshot.error,
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onChanged: _bloc.inPassword,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 64.0,
                              ),
                              StreamBuilder<bool>(
                                stream: _bloc.validator,
                                builder: (context, snapshot) {
                                  return RaisedButton(
                                    onPressed: () async {
                                      if (snapshot.hasData) {
                                        final state = await _bloc.signIn(BlocProvider.of<UserBloc>(context));
                                        final navigator = Navigator.of(context);
                                        switch (state) {
                                          case LoginState.INVALID_EMAIL:
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        "Este usuario nao esta cadastrado"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text("OK"),
                                                        onPressed:
                                                            navigator.pop,
                                                      )
                                                    ],
                                                  );
                                                });
                                            break;
                                          case LoginState.INVALID_PASS:
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content:
                                                        Text("Senha invalida"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text("OK"),
                                                        onPressed:
                                                            navigator.pop,
                                                      )
                                                    ],
                                                  );
                                                });
                                            break;
                                          case LoginState.DONE:
                                            navigator.pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(),
                                              ),
                                            );
                                            break;
                                          case LoginState.NETWORK_ERROR:
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        "Erro, verifique a sua conexao e tente novamente mais tarde."),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text("OK"),
                                                        onPressed:
                                                            navigator.pop,
                                                      )
                                                    ],
                                                  );
                                                });
                                            break;
                                          default:
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        "Erro, tente novamente mais tarde."),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text("OK"),
                                                        onPressed:
                                                            navigator.pop,
                                                      )
                                                    ],
                                                  );
                                                });
                                            break;
                                        }
                                      } else {
                                        _bloc.validateFields();
                                      }
                                    },
                                    child: Text(
                                      "Acessar a conta",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    splashColor: Colors.pinkAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          VollupLogo(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<LoginState>(
            stream: _bloc.outState,
            builder: (context, snapshot) {
              return snapshot.data == LoginState.LOADING
                  ? Container(
                      color: Colors.black54,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "Carregando...",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container();
            },
          )
        ],
      ),
    );
  }
}
