import 'package:flutter/material.dart';
import 'package:rymak/source/pages/user_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 120),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Image.asset('assets/images/logo_rymak.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: "Usuario"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: "Contraseña"),
                ),
              ),
              ElevatedButton(onPressed: _login, child: Text("Iniciar Sesión"))
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserPage()));
  }
}
