import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ongkos_kirim/app/data/models/user_model.dart';

void main() async {
  final apiKey = "e8814a1f1791a74cf3ffabb32326f7f7";
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

  final response = await http.post(
    url,
    body: {
      "origin": "501",
      "destination": "115",
      "weight": "1700",
      "courier": "jne",
    },
    headers: {
      "key": apiKey,
      "content-type": "application/x-www-form-urlencoded",
    },
  );
  print(response.body);

  // final response = await http.get(
  //   url,
  //   headers: {"key": apiKey},
  // );

  // print(response.body);
  // Uri url = Uri.parse("https://reqres.in/api/users/3");
  // final response = await http.get(url);

  // // print((json.decode(response.body) as Map<String, dynamic>)["support"]);
  // final user =
  //     UserModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
  // print(user.data!.firstName);
  // print(user);
}
