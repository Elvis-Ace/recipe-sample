import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class Basedata{
  static Color basecolor = Colors.green;
  String baseurl = "https://api.spoonacular.com/recipes/";
  String auth = "?apiKey=6ffd80d3f67949088905e7514357a2ff";
  List<String> recipes = [
    'Pasta',
    'Chicken',
    'Grilled',
    'Salad',
    'Cake',
    'Stew',
    'Fry',
    'Scampi',
    'Burger',
    'Pie',
  ];
  final dio = Dio();
  Future<Map> getData(String page,String url) async {
    Map<String, dynamic> requestHeaders = await custonheaders();
    debugPrint('$baseurl$page$auth&$url');
    Response response;

    try {
      response = await dio.get(
        '$baseurl$page$auth&$url',
        options: Options(
          headers: requestHeaders,
        ),
      );
      debugPrint(response.data.toString());
      return response.data;
    } on DioException catch (e) {
      return {
        'results':false
      };
    }


  }

  Future<Map> postData(String url, map) async {
    Map<String, dynamic> requestHeaders = await custonheaders();
    Response response = await dio.post(
      url,
      data: map, // Creates a Stream<List<int>>.
      options: Options(
        headers: requestHeaders,
      ),
    );
    debugPrint(response.data.toString());
    return response.data;
  }

  custonheaders() async {
    Map<String, String> requestHeaders = {};
    requestHeaders = {
      'Accept': 'application/json',
    };

    return requestHeaders;
  }
  bool comparestring(String s1,String s2){
    if(s1.toLowerCase() == s2.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

}