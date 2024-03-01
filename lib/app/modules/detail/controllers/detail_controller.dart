import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/detail_anime.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

class DetailController extends GetxController {
  var isLoading = true.obs;
  var detailAnime = <AnimeDetail>[].obs;

  Future<void> fetchDetailAnime(int id) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/anime/$id"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body)["data"];
        detailAnime.value = [AnimeDetail.fromJson(result)];
        isLoading.value = !isLoading.value;
      }
    } catch (e) {
      debugPrint("Gagal fetch : $e");
    }
  }

  String formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dateTime);
  }

  String formatMonth(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
  }

  String cutString(String inputString) {
    int index = inputString.indexOf('-');
    if (index != -1) {
      return inputString.substring(0, index).trim();
    } else {
      return inputString;
    }
  }

  double convertScoreToRating(double score) {
    // Menggunakan pembulatan ke bawah untuk mendapatkan peringkat 1-5
    double rating = (score / 2).clamp(1.0, 5.0);
    return double.parse(rating.toStringAsFixed(1));
  }

  @override
  void onInit() {
    fetchDetailAnime(Get.arguments);
    super.onInit();
  }
}