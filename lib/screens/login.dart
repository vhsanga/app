import 'dart:ui';
import 'package:app/api/api_service.dart';
import 'package:app/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/Theme.dart';

//widgets
import 'package:app/widgets/navbar.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/drawer.dart';

import 'package:http/http.dart' as http;
import '../ProgressHUD.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;
  LoginRequestModel loginRequestModel;
  final controllerUsuario = TextEditingController();
  final controllerClave = TextEditingController();
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }


  @override
  Widget _uiSetup(BuildContext context) {
    loginRequestModel = new LoginRequestModel();
     //controllerUsuario.dispose();
     //controllerClave.dispose();
    return Scaffold(
        key: scaffoldKey,
        appBar: Navbar(transparent: true, title: ""),
        extendBodyBehindAppBar: true,
        drawer: ArgonDrawer(currentPage: "Account"),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.63,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 24.0),
                                        child: Center(
                                          child: Text(
                                              "Ingresar a la aplicacion",
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: "Usuario",
                                              prefixIcon:
                                                  Icon(Icons.account_box),   
                                              controller: controllerUsuario,                                     
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: "Password",
                                              prefixIcon: Icon(Icons.lock),
                                              controller: controllerClave,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                            child: FlatButton.icon(
                                                textColor: ArgonColors.white,
                                                color: ArgonColors.primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4.0),
                                                ),
                                                onPressed: () {
                                                  loginRequestModel.email = controllerUsuario.text;
                                                  loginRequestModel.password = controllerUsuario.text;
                                                  APIService apiService = new APIService();
                                                  apiService.login(loginRequestModel).then((value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      isApiCallProcess = false;
                                                    });

                                                    if (value.token.isNotEmpty) {
                                                      final snackBar = SnackBar(
                                                          content: Text("Login Successful"));
                                                      scaffoldKey.currentState
                                                          .showSnackBar(snackBar);
                                                    } else {
                                                      final snackBar =
                                                          SnackBar(content: Text(value.error));
                                                      scaffoldKey.currentState
                                                          .showSnackBar(snackBar);
                                                    }
                                                  }
                                                });
                                                  // Respond to button press
                                                  Navigator.pushNamed(
                                                      context, '/home');
                                                },
                                                icon: Icon(Icons.account_box),
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 16.0,
                                                      top: 12,
                                                      bottom: 12),
                                                  child: Text("INGRESAR",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16.0)))
                                                  )                                          
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }
}
