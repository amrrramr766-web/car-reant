import 'package:http/http.dart' as http;

Future<bool> checkInternet() async {
  try {
    final response = await http
        .get(Uri.parse("https://www.google.com"))
        .timeout(const Duration(seconds: 3)); // Set timeout to avoid long wait

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
