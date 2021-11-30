import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rymak/models/models.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hola'),
      ),
      body: _body(),
    );
  }

  _getContratos() async {
    var url = Uri.parse('http://palma.6te.net/index.php');
    var response = await http.get(url);
    print('Response body: ${response.body}');
    final contrato = Contrato.fromJson(response.body);
    print("${contrato.idContrato} ${contrato.titleContrato}");
  }

  Widget _body() {
    _getContratos();
    return ListView(
      children: [
        ListTile(
          title: Text('testing'),
        ),
        ElevatedButton(onPressed: _getContratos, child: Text('hola'))
      ],
    );
  }
}
