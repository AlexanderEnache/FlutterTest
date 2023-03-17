// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemUPC{
  static Future<String> getUPC(qrCode) async {
    final client = http.Client();
    final queryParameters = {
      'x-app-id': '319c0339',
      'x-app-key': 'f86cb82b0bdbc3decd5168012b49f746',
      'upc': qrCode 
    };

    var url = Uri.https('trackapi.nutritionix.com', '/v2/search/item', queryParameters);
    var response = await client.get(url);

    if(response.statusCode == 200){
      Map<String, dynamic> json = jsonDecode(response.body);
      print(json.entries.first.value[0]['food_name']);
      return json.entries.first.value[0]['food_name'];
    }else{
      print("ERRRRRRRROR");
      print(response.statusCode);
      return response.statusCode.toString();
    }
  }

  static Future<String> getPhoto(qrCode) async {
    final client = http.Client();
    final queryParameters = {
      'x-app-id': '319c0339',
      'x-app-key': 'f86cb82b0bdbc3decd5168012b49f746',
      'upc': qrCode 
    };

    var url = Uri.https('trackapi.nutritionix.com', '/v2/search/item', queryParameters);
    var response = await client.get(url);

    if(response.statusCode == 200){
      Map<String, dynamic> json = jsonDecode(response.body);
      print(json.entries.first.value[0]['photo']['thumb'] + "___" + json.entries.first.value[0]['food_name']);
      return json.entries.first.value[0]['photo']['thumb'] + "***token***" + json.entries.first.value[0]['food_name'];
    }else{
      print("ERRRRRRRROR");
      print(response.statusCode);
      return response.statusCode.toString();
    }
  }
}