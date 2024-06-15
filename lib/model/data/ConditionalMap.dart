class ConditionalMap {
  ConditionalMap({
      this.dependantFieldName, 
      this.value,});

  ConditionalMap.fromJson(dynamic json) {
    dependantFieldName = json['dependantFieldName'];
    value = json['value'] != null ? Value.fromJson(json['value']) : null;
  }
  String? dependantFieldName;
  Value? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dependantFieldName'] = dependantFieldName;
    if (value != null) {
      map['value'] = value?.toJson();
    }
    return map;
  }

}

class Value {
  Value({
      this.dsa, 
      this.connector,});

  Value.fromJson(dynamic json) {
    dsa = json['DSA'] != null ? json['DSA'].cast<String>() : [];
    connector = json['Connector'] != null ? json['Connector'].cast<String>() : [];
  }
  List<String>? dsa;
  List<String>? connector;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DSA'] = dsa;
    map['Connector'] = connector;
    return map;
  }

}