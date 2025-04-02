import 'package:http/http.dart' as http;

// * https://api.github.com/repos/DaviD4Chirino/doctor_perro_helper/releases/latest

Future<bool> updateAvailable() async {
  final httpPackageUrl = Uri.https(
    "api.github.com",
    "/repos/DaviD4Chirino/doctor_perro_helper/releases/latest",
  );

  final httpPackageInfo = await http.read(httpPackageUrl);
  print(httpPackageInfo);

  return false;
}
