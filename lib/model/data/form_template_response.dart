import 'dart:convert';

class FormTemplateResponse {
  FormTemplateResponse({
    this.formKey,
    this.formName,
    this.description,
    this.entityType,
    this.isBaseTable,
    this.multipleAllowed,
    this.parameters,
    this.categories,
  });

  FormTemplateResponse.fromJson(dynamic json) {
    formKey = json['formKey'];
    formName = json['formName'];
    description = json['description'];
    entityType = json['entityType'];
    isBaseTable = json['isBaseTable'];
    multipleAllowed = json['multipleAllowed'];
    if (json['parameters'] != null) {
      parameters = [];
      json['parameters'].forEach((v) {
        parameters?.add(Parameters.fromJson(v));
      });
    }
    categories =
        json['categories'] != null ? json['categories'].cast<String>() : [];
  }

  String? formKey;
  String? formName;
  String? description;
  String? entityType;
  bool? isBaseTable;
  bool? multipleAllowed;
  List<Parameters>? parameters;
  List<String>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['formKey'] = formKey;
    map['formName'] = formName;
    map['description'] = description;
    map['entityType'] = entityType;
    map['isBaseTable'] = isBaseTable;
    map['multipleAllowed'] = multipleAllowed;
    if (parameters != null) {
      map['parameters'] = parameters?.map((v) => v.toJson()).toList();
    }
    map['categories'] = categories;
    return map;
  }
}

class Parameters {
  Parameters(
      {this.id,
      this.name,
      this.displayName,
      this.dataType,
      this.possibleValues,
      this.isMandatory,
      this.isEditable,
      this.isHidden,
      this.isAdditionalField,
      this.displayOrder,
      this.length,
      this.categoryValue,
      this.category,
      this.defaultSelection,
      this.possibleValuesMap});

  Parameters.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    dataType = json['dataType'];
    possibleValues = json['possibleValues'] != null
        ? json['possibleValues'].cast<String>()
        : [];
    isMandatory = json['isMandatory'];
    isEditable = json['isEditable'];
    isHidden = json['isHidden'];
    isAdditionalField = json['isAdditionalField'];
    displayOrder = json['displayOrder'];
    length = json['length'];
    categoryValue = json['categoryValue'];
    category = json['category'];
    defaultSelection = json['defaultSelection'];
    possibleValuesMap = (json['possibleValuesMap'] != null)
        ? jsonDecode(json['possibleValuesMap'])
        : null;
  }

  int? id;
  String? name;
  String? displayName;
  String? dataType;
  List<String>? possibleValues;
  bool? isMandatory;
  bool? isEditable;
  bool? isHidden;
  bool? isAdditionalField;
  int? displayOrder;
  int? length;
  String? categoryValue;
  String? category;
  String? defaultSelection;
  Map? possibleValuesMap;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['displayName'] = displayName;
    map['dataType'] = dataType;
    map['possibleValues'] = possibleValues;
    map['isMandatory'] = isMandatory;
    map['isEditable'] = isEditable;
    map['isHidden'] = isHidden;
    map['isAdditionalField'] = isAdditionalField;
    map['displayOrder'] = displayOrder;
    map['length'] = length;
    map['categoryValue'] = categoryValue;
    map['category'] = category;
    map['defaultSelection'] = defaultSelection;
    map['possibleValuesMap'] = possibleValuesMap;
    return map;
  }
}
