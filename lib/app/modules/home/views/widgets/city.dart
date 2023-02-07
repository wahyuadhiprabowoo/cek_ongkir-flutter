import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../city_model.dart';
import '../../controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({Key? key, required this.provId, required this.tipe})
      : super(key: key);
  final int provId;
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownSearch<City>(
        label: tipe == "asal" ? "Kota/Kabupaten Asal" : "Kota/Kabupaten Tujuan",
        onFind: (String filter) async {
          final apiKey = "e8814a1f1791a74cf3ffabb32326f7f7";
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=${provId}");
          try {
            final response = await http.get(
              url,
              headers: {"key": apiKey},
            );
            var data = json.decode(response.body) as Map<String, dynamic>;
            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;
            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (e) {
            return List<City>.empty();
          }
        },
        onChanged: (city) {
          if (city != null) {
            if (tipe == "asal") {
              controller.cityIdAsal.value = int.parse(city.cityId!);
              controller.provIdAsal.value = int.parse(city.provinceId!);
            } else {
              controller.cityIdTujuan.value = int.parse(city.cityId!);
              controller.provIdTujuan.value = int.parse(city.provinceId!);
            }
          } else {
            if (tipe == "asal") {
              controller.cityIdAsal.value = 0;
            } else {
              controller.cityIdTujuan.value = 0;
            }
          }
          controller.showButton();
        },
        popupItemBuilder: (context, item, isSelected) => Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text("${item.type} - ${item.cityName} "),
          ),
        ),
        itemAsString: (item) => item.cityName!,
        showSearchBox: true,
        showClearButton: true,
        searchBoxDecoration: InputDecoration(hintText: "cari kota/kabupaten"),
      ),
    );
  }
}
