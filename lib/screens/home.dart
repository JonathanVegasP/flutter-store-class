import 'package:flutter/material.dart';
import 'package:flutter_store/blocs/user_bloc.dart';
import 'package:flutter_store/inherited/bloc_provider.dart';
import 'package:flutter_store/resources/colors.dart';
import 'package:flutter_store/resources/images.dart';
import 'package:flutter_store/screens/add_product.dart';
import 'package:flutter_store/widgets/logo_widget.dart';
import 'package:flutter_store/widgets/vollup_logo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              LogoWidget(),
              Column(
                children: <Widget>[
                  Text(
                    "Ola, ${user.user.name}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductScreen()));
                    },
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.add_circle_outline),
                        const SizedBox(
                          width: 24.0,
                        ),
                        Text(
                          "Adicionar Produto",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  RaisedButton(
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage(BagImage),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Text(
                          "Efetuar uma venda",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              VollupLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
