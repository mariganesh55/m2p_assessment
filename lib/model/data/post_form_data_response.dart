class PostFormDataResponse {
  PostFormDataResponse({
    this.resourceId,
    this.rollbackTransaction,
  });

  PostFormDataResponse.fromJson(dynamic json) {
    resourceId = json['resourceId'];
    rollbackTransaction = json['rollbackTransaction'];
  }

  int? resourceId;
  bool? rollbackTransaction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resourceId'] = resourceId;
    map['rollbackTransaction'] = rollbackTransaction;
    return map;
  }
}
