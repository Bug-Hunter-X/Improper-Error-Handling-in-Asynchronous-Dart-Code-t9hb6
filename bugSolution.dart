```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // More specific exception handling:
      throw HttpException('HTTP request failed with status: ${response.statusCode}', response.body);
    }
  } on SocketException {
    // Handle network errors specifically:
    throw Exception('Network error: Please check your internet connection.');
  } on FormatException catch (e) {
    // Handle JSON decoding errors:
    throw Exception('Invalid JSON format: $e');
  } catch (e) {
    // Generic catch for other unexpected errors:
    throw Exception('An unexpected error occurred: $e');
  }
}

// Custom exception to improve error handling clarity
class HttpException implements Exception {
  final String message;
  final String? responseBody; // Optionally include the response body

  HttpException(this.message, [this.responseBody]);

  @override
  String toString() => message;
}

void main() async {
  try {
    final data = await fetchData();
    if (data != null) {
      print('Name: ${data['name']}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
```