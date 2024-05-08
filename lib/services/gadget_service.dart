import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gadget.dart';

class GadgetService {
  static Future<List<Gadget>> fetchGadgets() async {
    const url = 'https://gist.githubusercontent.com/lathindu1/bf8e7a29e1b04153af43cb2b0d18b02a/raw/e58f5ea61ee448a70e87be707bdaec51437620c6/products.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> gadgetJsonList = json.decode(response.body);
      return gadgetJsonList.map((json) => Gadget.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load gadgets');
    }
  }
}
