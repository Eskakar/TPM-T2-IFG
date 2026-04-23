import 'dart:convert';
import 'package:http/http.dart' as http;

class KursService {
  static Future<double> convertIDR(double amount, String to) async {
    final url = Uri.parse(
      'https://api.frankfurter.app/latest?from=IDR&to=$to',
    );

    final response = await http.get(url);
    final data = json.decode(response.body);

    double rate = data['rates'][to];
    return amount * rate;
  }
}