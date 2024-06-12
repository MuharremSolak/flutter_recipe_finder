import 'package:http/http.dart' as http;
import 'dart:convert';

class MealService {
  final String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<dynamic>> fetchMealsByCategory(String category) async {
    print('Fetching meals for category: $category');
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print('Data fetched: ${data['meals']}');
      return data['meals'];
    } else {
      print('Failed to fetch meals. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch meals by category');
    }
  }

  Future<List<dynamic>> fetchCategories() async {
    print('Fetching categories');
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print('Categories fetched: ${data['categories']}');
      return data['categories'];
    } else {
      print('Failed to fetch categories. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch categories');
    }
  }

  Future<List<dynamic>> searchMeals(String query) async {
    print('Searching meals for query: $query');
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print('Data fetched: ${data['meals']}');
      return data['meals'];
    } else {
      print('Failed to search meals. Status code: ${response.statusCode}');
      throw Exception('Failed to search meals');
    }
  }

  Future<Map<String, dynamic>> fetchMealDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['meals'][0];
    } else {
      throw Exception('Failed to load meal details');
    }
  }
}
