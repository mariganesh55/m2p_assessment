class ClientLoginResponse {
  ClientLoginResponse({
    this.changes,
    this.resourceIdentifier,
  });

  ClientLoginResponse.fromJson(dynamic json) {
    changes = json['changes'];
    resourceIdentifier = json['resourceIdentifier'];
  }

  dynamic changes;
  String? resourceIdentifier;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['changes'] = changes;
    map['resourceIdentifier'] = resourceIdentifier;
    return map;
  }
}
