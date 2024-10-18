import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dummyapi.io/data/v1';
  static const String appId =
      '666a92cbe42133bf4cdb3081'; // Replace with your app-id

  Future<Map<String, dynamic>> fetchUsers(int page, int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user?limit=$limit&page=$page'),
      headers: {'app-id': appId},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
