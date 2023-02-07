import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widgets/city.dart';
import 'widgets/province.dart';
import 'widgets/berat.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ongkos Kirim Indonesia'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: ListView(
            children: [
              // mengambil data provinsi dari API rajaongkir
              Provinsi(tipe: "asal"),
              Obx(
                () => controller.hiddenCityAsal.isTrue
                    ? SizedBox()
                    : Kota(
                        provId: controller.provIdAsal.value,
                        tipe: "asal",
                      ),
              ),
              Provinsi(tipe: "tujuan"),
              Obx(
                () => controller.hiddenCityAsal.isTrue
                    ? SizedBox()
                    : Kota(
                        provId: controller.provIdTujuan.value,
                        tipe: "tujuan",
                      ),
              ),
              BeratBarang(),
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: DropdownSearch<Map<String, dynamic>>(
                  mode: Mode.MENU,
                  maxHeight: 150,
                  // showSelectedItem: true,
                  items: [
                    {
                      "code": "jne",
                      "name": "Jalur Nugraha Ekakurir (JNE)",
                    },
                    {
                      "code": "tiki",
                      "name": "Titipan Kilat",
                    },
                    {
                      "code": "pos",
                      "name": "Pos Indonesia",
                    },
                  ],
                  label: "Pilihan Kurir",
                  hint: "pilih kurir anda",
                  onChanged: (value) {
                    if (value != null) {
                      controller.kurir.value = value["code"];
                      controller.showButton();
                    } else {
                      controller.hiddenButton.value = true;
                      controller.kurir.value = "";
                    }
                  },
                  showClearButton: true,
                  itemAsString: (item) => "${item["name"]}",
                  popupItemBuilder: (context, item, isSelected) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.hiddenButton.isTrue
                    ? SizedBox()
                    : ElevatedButton(
                        onPressed: () => controller.ongkosKirim(),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.cyan,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Cek Ongkos Kirim"),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
