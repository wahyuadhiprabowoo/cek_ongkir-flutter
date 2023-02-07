import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controllers/home_controller.dart';
import '../../province_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    Key? key,
    required this.tipe,
  }) : super(key: key);

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownSearch<Province>(
        label: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        onFind: (String filter) async {
          final apiKey = "e8814a1f1791a74cf3ffabb32326f7f7";
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          try {
            final response = await http.get(
              url,
              headers: {"key": apiKey},
            );
            var data = json.decode(response.body) as Map<String, dynamic>;
            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;
            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            return List<Province>.empty();
          }
        },
        onChanged: (prov) {
          if (prov != null) {
            if (tipe == "asal") {
              controller.hiddenCityAsal.value = false;
              controller.provIdAsal.value = int.parse(prov.provinceId!);
            } else {
              controller.hiddenCityTujuan.value = false;
              controller.provIdTujuan.value = int.parse(prov.provinceId!);
            }
          } else {
            if (tipe == "asal") {
              controller.hiddenCityAsal.value = true;
              controller.provIdAsal.value = 0;
            } else {
              controller.hiddenCityTujuan.value = true;
              controller.provIdTujuan.value = 0;
            }
          }
          controller.showButton();
        },
        popupItemBuilder: (context, item, isSelected) => Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text("${item.province}"),
          ),
        ),
        itemAsString: (item) => item.province!,
        showSearchBox: true,
        showClearButton: true,
        searchBoxDecoration: InputDecoration(hintText: "cari provinsi"),
      ),
    );
  }
}
