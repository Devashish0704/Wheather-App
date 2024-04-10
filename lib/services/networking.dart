import 'dart:convert';
import 'package:http/http.dart' as http;

class Networking {
  Networking({
    required this.URLstring1,
  });

  final String URLstring1;

  Future<dynamic> getData() async {
    var url = Uri.parse(
      URLstring1,
    );

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null; // Return null to indicate failure
      }
    } catch (e) {
      print('Error loading data: $e');
      return null; // Return null to indicate failure
    }
  }
}
