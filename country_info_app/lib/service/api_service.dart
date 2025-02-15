import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://restcountries.com/v3.1/all";
  static String apiKey = "2214|tm2zF5X2puugDO0S68DkGt0jGgpPcGcZ2oO6opUx";

  Future<List<dynamic>> fetchCountries() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load countries");
    }
  }
}
