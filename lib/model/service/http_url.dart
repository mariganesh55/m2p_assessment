class HttpUrls {
  static const String baseURL = "www.google.com";
  static const String login =
      "http://localhost:8080/fineract-provider/api/v1/auth/clientlogin";
  static const String accessToken =
      "$baseURL/fineract-provider/api/oauth/token";
  static const String clientDataSuccess =
      "${baseURL}/fineract-provider/api/v1/self/userdetails?access_token=d3893185-d591-4087-a170-bdcda05692a4";
  static const String formTemplate =
      "${baseURL}/fineract-provider/api/v3/forms/dsa-form";
  static const String getFormData =
      "${baseURL}/fineract-provider/api/v3/forms/clients/225152/dsa-form";
}
