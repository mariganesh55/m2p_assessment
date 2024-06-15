import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:m2p_assessment/model/data/GetFormDataResponse.dart';
import 'package:m2p_assessment/model/data/access_token_response.dart';
import 'package:m2p_assessment/model/data/client_login_response.dart';
import 'package:m2p_assessment/model/data/form_template_response.dart';
import 'package:m2p_assessment/model/data/post_form_data_response.dart';

class ApiService {
  static Future<ClientLoginResponse> getClientLoginResponse() async {
    try {
      String data =
          await rootBundle.loadString('assets/json/client_login_response.json');
      ClientLoginResponse response =
          ClientLoginResponse.fromJson(json.decode(data));
      return response;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }

  static Future<AccessTokenResponse> getAccessToken(
      {required String otp}) async {
    try {
      String data =
          await rootBundle.loadString('assets/json/access_token_response.json');
      AccessTokenResponse response =
          AccessTokenResponse.fromJson(json.decode(data));
      return response;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }

  static Future<GetFormDataResponse> getFormDataResponse() async {
    try {
      String data = await rootBundle
          .loadString('assets/json/get_form_data_response.json');
      GetFormDataResponse response =
          GetFormDataResponse.fromJson(json.decode(data));
      return response;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }

  static Future<FormTemplateResponse> getFormTemplateResponse() async {
    try {
      String data = await rootBundle
          .loadString('assets/json/form_template_response.json');
      FormTemplateResponse response =
          FormTemplateResponse.fromJson(json.decode(data));
      return response;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }

  static Future<PostFormDataResponse> postFromDataResponse() async {
    try {
      String data = await rootBundle
          .loadString('assets/json/post_form_data_response.json');
      PostFormDataResponse response =
          PostFormDataResponse.fromJson(json.decode(data));
      return response;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }
}
