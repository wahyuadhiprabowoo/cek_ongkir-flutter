import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkos_kirim/app/modules/home/courier_model.dart';

class HomeController extends GetxController {
  var hiddenCityAsal = true.obs;
  var hiddenCityTujuan = true.obs;
  var hiddenButton = true.obs;
  var provIdAsal = 0.obs;
  var provIdTujuan = 0.obs;
  var cityIdAsal = 0.obs;
  var cityIdTujuan = 0.obs;
  var kurir = "".obs;

  double berat = 0.0;
  String satuan = "gram";

  late TextEditingController beratC;

  void ongkosKirim() async {
    final apiKey = "e8814a1f1791a74cf3ffabb32326f7f7";
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(
        url,
        body: {
          "origin": "${cityIdAsal}",
          "destination": "${cityIdTujuan}",
          "weight": "${berat}",
          "courier": "${kurir}",
        },
        headers: {
          "key": apiKey,
          "content-type": "application/x-www-form-urlencoded",
        },
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      // ambil results
      var results = data["rajaongkir"]["results"] as List<dynamic>;
      var listAllCourier = Courier.fromJsonList(results);
      var courier = listAllCourier[0];

      Get.defaultDialog(
        title: courier.name!,
        content: Column(
          children: courier.costs!
              .map((e) => ListTile(
                    title: Text("${e.service}"),
                    subtitle: Text("Rp. ${e.cost![0].value}"),
                    trailing: Text(courier.code == "pos"
                        ? "${e.cost![0].etd}"
                        : "${e.cost![0].etd} Hari"),
                  ))
              .toList(),
        ),
      );
      // print(data);
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        content: Text(e.toString()),
      );
      print(e);
    }
  }

  void showButton() {
    if (cityIdAsal != 0 && cityIdTujuan != 0 && berat > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    // pengaturan untuk handle berat
    berat = double.tryParse(value) ?? 0.0;

    String cekSatuan = satuan;

    switch (cekSatuan) {
      case "ton":
        berat *= 1000000;
        break;
      case "kwintal":
        berat *= 100000;
        break;
      case "ons":
        berat *= 100;
        break;
      case "lbs":
        berat *= 2204.62;
        break;
      case "pound":
        berat *= 2204.62;
        break;
      case "kg":
        berat *= 1000;
        break;
      case "hg":
        berat *= 100;
        break;
      case "dag":
        berat *= 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat /= 10;
        break;
      case "cg":
        berat /= 100;
        break;
      case "mg":
        berat /= 1000;
        break;
      default:
        berat = berat;
    }
    print("${berat} dari ubah berat gram");
    showButton();
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat *= 1000000;
        break;
      case "kwintal":
        berat *= 100000;
        break;
      case "ons":
        berat *= 100;
        break;
      case "lbs":
        berat *= 2204.62;
        break;
      case "pound":
        berat *= 2204.62;
        break;
      case "kg":
        berat *= 1000;
        break;
      case "hg":
        berat *= 100;
        break;
      case "dag":
        berat *= 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat /= 10;
        break;
      case "cg":
        berat /= 100;
        break;
      case "mg":
        berat /= 1000;
        break;
      default:
        berat = berat;
    }
    satuan = value;
    print("${berat} gram dari ubah satuan");
    showButton();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    beratC = TextEditingController(text: "${berat}");
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    beratC.dispose();
    super.onClose();
  }
}
