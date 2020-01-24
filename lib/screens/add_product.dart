import 'package:flutter/material.dart';
import 'package:flutter_store/resources/colors.dart';
import 'package:flutter_store/widgets/logo_widget.dart';
import 'package:flutter_store/widgets/vollup_logo.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: LogoWidget(width: 150.0,),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(color: Colors.white,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: Center(
                      child: Icon(Icons.camera_alt, color: Colors.white,size: 40,),
                    ),
                  ),
                  const SizedBox(height: 24.0,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Produto",
                    ),
                  ),
                  const SizedBox(
                      height: 24.0
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Quantidade",
                          ),
                        ),
                      ),
                      const SizedBox(width: 24.0,),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Preco",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0,),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Codigo de barras"
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  RaisedButton(
                    onPressed: () => false,
                    child: Text(
                      "Salvar".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    splashColor: Colors.black26,
                    highlightColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: VollupLogo(),
            ),
          ],
        ),
      )
    );
  }
}
