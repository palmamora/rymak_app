class Unidad {
  String idUnidad;
  String typeUnidad;

  Unidad({
    required this.idUnidad,
    required this.typeUnidad,
  });

  static listFromJson(List<Map<String, dynamic>> list) {
    List<Unidad> unidades = [];
    for (var value in list) {
      unidades.add(Unidad.fromJson(value));
    }
    return unidades;
  }

  static fromJson(Map<String, dynamic> parsedJson) {
    return Unidad(
      idUnidad: parsedJson['idUnidad'],
      typeUnidad: parsedJson['typeUnidad'],
    );
  }
}
