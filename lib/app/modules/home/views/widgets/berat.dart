import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkos_kirim/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.beratC,
              autocorrect: false,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: "Masukan berat",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.ubahBerat(value),
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 120,
            child: DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                showSelectedItem: true,
                showSearchBox: true,
                searchBoxDecoration: InputDecoration(hintText: "satuan berat"),
                items: [
                  "ton",
                  "kwintal",
                  "ons",
                  "lbs",
                  "pound",
                  "kg",
                  "hg",
                  "dag",
                  "gram",
                  "dg",
                  "cg",
                  "mg"
                ],
                label: "Satuan",
                hint: "country in menu mode",
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (value) => controller.ubahSatuan(value!),
                selectedItem: "gram"),
          ),
        ],
      ),
    );
  }
}
