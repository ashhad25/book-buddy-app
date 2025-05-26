import 'dart:convert';
import 'dart:io';

import 'package:book_buddy/GetX%20MVVM/data/app_exceptions.dart';
import 'package:book_buddy/GetX%20MVVM/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  dynamic responceJson;

  @override
  Future getUserAPi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await http
          .get(Uri.parse(url), headers: {'x-api-key': 'reqres-free-v1'})
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        responceJson = returnResponse(response);
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responceJson;
  }

  @override
  Future getBooksApi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        responceJson = returnResponse(response);
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responceJson;
  }

  @override
  Future getBooksGenreApi(String url, String genre) async {
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await http.get(Uri.parse('$url?topic=$genre'));
      if (response.statusCode == 200) {
        responceJson = returnResponse(response);
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responceJson;
  }

  @override
  Future getBooksQueryApi(String url, String query) async {
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await http.get(Uri.parse('$url?search=$query'));
      if (response.statusCode == 200) {
        responceJson = returnResponse(response);
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responceJson;
  }

  @override
  Future postUserApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'x-api-key': 'reqres-free-v1'},
            body:
                data, //if not in raw form then you do not need jsonENcode() method
          )
          .timeout(Duration(seconds: 10));
      responceJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responceJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responceJson = jsonDecode(response.body);
        return responceJson;
      case 400:
        dynamic responceJson = jsonDecode(response.body);
        return responceJson;
      default:
        throw FetchDataException(
          'Error occured while comunication with server ${response.statusCode}',
        );
    }
  }
}
