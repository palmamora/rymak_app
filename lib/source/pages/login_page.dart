import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:rymak/source/pages/user_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  dynamic _formKey = GlobalKey<FormState>();

  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 120),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Center(
                    child: Image.asset('assets/images/logo_rymak.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(labelText: "Usuario"),
                      controller: _userController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(labelText: "Contraseña"),
                      controller: _passController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await _login();

                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: Text("Iniciar Sesión"))
                ],
              ),
      ),
    );
  }

  Future<dynamic> _login() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://186.10.30.50:8081/include/adaptiva/app_getvalidation.php'));
    request.body = json.encode({
      "token": "WfjQzG4cSnSENv6ukFQo7FiaAxbP19qwYdij",
      "username": _userController.text,
      "password": _passController.text,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserPage(data)));
    } else {
      print(response.reasonPhrase);
    }
  }
}
