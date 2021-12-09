class Contratos {
  final List<Contrato> contratos;

  Contratos({
    required this.contratos,
  });

  factory Contratos.fromJson(List<dynamic> parsedJson) {
    List<Contrato> contratosList = [];
    contratosList = parsedJson.map((e) => Contrato.fromJson(e)).toList();
    return Contratos(
      contratos: contratosList,
    );
  }
}

class Contrato {
  final String idContrato;
  final String titleContrato;
  final String emailContrato;
  final List<dynamic> unidades;

  Contrato({
    required this.idContrato,
    required this.titleContrato,
    required this.emailContrato,
    required this.unidades,
  });

  factory Contrato.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['unidades'];
    List<dynamic> unidadesList = list.map((i) => Unidad.fromJson(i)).toList();
    return Contrato(
      idContrato: parsedJson['idContrato'],
      titleContrato: parsedJson['titleContrato'],
      emailContrato: parsedJson['emailContrato'],
      unidades: unidadesList,
    );
  }
}

class Unidad {
  final String? idUnidad;
  final String? typeUnidad;

  Unidad({
    required this.idUnidad,
    required this.typeUnidad,
  });

  factory Unidad.fromJson(Map<String, dynamic> parsedJson) {
    return Unidad(
      idUnidad: parsedJson['idUnidad'],
      typeUnidad: parsedJson['typeUnidad'],
    );
  }
}
