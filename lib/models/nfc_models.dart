// To parse this JSON data, do
//
//     final nfcTag2 = nfcTag2FromJson(jsonString);

import 'dart:convert';

class NfcTag2 {
  dynamic? isodep;
  dynamic? nfca;

  NfcTag2({this.isodep, this.nfca});

  factory NfcTag2.fromRawJson(String str) => NfcTag2.fromJson(json.decode(str));

  factory NfcTag2.fromJson(Map<String, dynamic> json) => NfcTag2(
        isodep: Isodep2.fromJson(json["isodep"]),
        nfca: Nfca2.fromJson(json["nfca"]),
      );

  factory NfcTag2.fromMap(Map<String, dynamic> json) => NfcTag2(
        isodep: json["isodep"] == null ? null : Isodep2.fromMap(json["isodep"]),
        nfca: json["nfca"] == null ? null : Nfca2.fromMap(json["nfca"]),
      );
}

class Nfca2 {
  dynamic? identifier;
  dynamic? atqa;
  dynamic? maxTransceiveLength;
  dynamic? sak;
  dynamic? timeout;

  Nfca2(
      {this.identifier,
      this.atqa,
      this.maxTransceiveLength,
      this.sak,
      this.timeout});

  factory Nfca2.fromJson(Map<dynamic, dynamic> json) => Nfca2(
        identifier: List<int>.from(json["identifier"].map((x) => x)),
        atqa: List<int>.from(json["atqa"].map((x) => x)),
        maxTransceiveLength: json["maxTransceiveLength"],
        sak: json["sak"],
        timeout: json["timeout"],
      );
  factory Nfca2.fromMap(Map<dynamic, dynamic> json) => Nfca2(
        identifier: json["identifier"] == null
            ? null
            : List<int>.from(json["identifier"].map((x) => x)),
        atqa: json["atqa"] == null
            ? null
            : List<int>.from(json["atqa"].map((x) => x)),
        maxTransceiveLength: json["maxTransceiveLength"] == null
            ? null
            : json["maxTransceiveLength"],
        sak: json["sak"] == null ? null : json["sak"],
        timeout: json["timeout"] == null ? null : json["timeout"],
      );
}

class Isodep2 {
  dynamic? identifier;
  dynamic? hiLayerResponse;
  dynamic? historicalBytes;
  dynamic? isExtendedLengthApduSupported;
  dynamic? maxTransceiveLength;
  dynamic? timeout;

  Isodep2(
      {this.identifier,
      this.hiLayerResponse,
      this.historicalBytes,
      this.isExtendedLengthApduSupported,
      this.maxTransceiveLength,
      this.timeout});

  factory Isodep2.fromJson(Map<dynamic, dynamic> json) => Isodep2(
        identifier: List<int>.from(json["identifier"].map((x) => x)),
        hiLayerResponse: json["hiLayerResponse"],
        historicalBytes: List<int>.from(json["historicalBytes"].map((x) => x)),
        isExtendedLengthApduSupported: json["isExtendedLengthApduSupported"],
        maxTransceiveLength: json["maxTransceiveLength"],
        timeout: json["timeout"],
      );

  factory Isodep2.fromMap(Map<dynamic, dynamic> json) => Isodep2(
        identifier: json["identifier"] == null
            ? null
            : List<int>.from(json["identifier"].map((x) => x)),
        hiLayerResponse: json["hiLayerResponse"],
        historicalBytes: json["historicalBytes"] == null
            ? null
            : List<int>.from(json["historicalBytes"].map((x) => x)),
        isExtendedLengthApduSupported:
            json["isExtendedLengthApduSupported"] == null
                ? null
                : json["isExtendedLengthApduSupported"],
        maxTransceiveLength: json["maxTransceiveLength"] == null
            ? null
            : json["maxTransceiveLength"],
        timeout: json["timeout"] == null ? null : json["timeout"],
      );
}
