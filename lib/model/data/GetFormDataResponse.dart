class GetFormDataResponse {
  GetFormDataResponse({
    this.payload,
    this.resourceId,
  });

  GetFormDataResponse.fromJson(dynamic json) {
    if (json['payload'] != null) {
      payload = [];
      json['payload'].forEach((v) {
        payload?.add(Payload.fromJson(v));
      });
    }
    resourceId = json['resourceId'];
  }

  List<Payload>? payload;
  int? resourceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (payload != null) {
      map['payload'] = payload?.map((v) => v.toJson()).toList();
    }
    map['resourceId'] = resourceId;
    return map;
  }
}

class Payload {
  Payload({
    this.id,
    this.name,
    this.value,
  });

  Payload.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  int? id;
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['value'] = value;
    return map;
  }
}
