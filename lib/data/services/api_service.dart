import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

class ApiService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.login),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getDashboardData() async {
    final response = await http.get(Uri.parse(ApiEndpoints.dashboard));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getProducts() async {
    final response = await http.get(Uri.parse(ApiEndpoints.products));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> createTransaction(
      Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.transactions),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
