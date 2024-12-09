// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uas/models/product.dart';

class ApiService {
  final String baseUrl = 'http://localhost/uas-pos/';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> getDashboardSummary() async {
    final response = await http.get(Uri.parse('$baseUrl/dashboard/summary'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get dashboard summary');
    }
  }

  Future<List<double>> getWeeklySales() async {
    final response =
        await http.get(Uri.parse('$baseUrl/dashboard/weekly-sales'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<double>.from(data['sales']);
    } else {
      throw Exception('Failed to get weekly sales');
    }
  }

  Future<void> checkout(List<Map<String, dynamic>> items) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'items': items}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to checkout');
    }
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Map<String, dynamic>> createTransaction(
      Map<String, dynamic> transaction) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(transaction),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create transaction');
    }
  }
}
