import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app/controllers/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app/api/api_helper.dart';
import 'package:app/consts/enums.dart';
import 'package:app/helpers/snakbar.dart';
import 'package:app/models/api/base_object_response.dart';

class ApiController with ApiHelper, SnackBarHelper {
  Future<BaseApiObjectResponse?> request<T>({
    required String link,
    required ApiRequestType requestType,
    Map<String, dynamic>? body,
    bool requiresAuth = false,
    bool snack = true,
    bool checkData = true,
    bool printResult = false,
    bool html = false,
  }) async {
    var authC = Get.find<AuthController>();
    if (requiresAuth && !authC.loggedIn_) {
      if (snack) {
        showSnackBar(message: 'requiredAuthForAction'.tr, error: true);
      }
      return null;
    } else {
      try {
        var url = Uri.parse(link);
        http.Response response;
        var body_ = json.encode(body);
        switch (requestType) {
          case ApiRequestType.get:
            response = await http.get(url, headers: httpHeaders);
            break;
          case ApiRequestType.post:
            response = await http.post(url, body: body_, headers: httpHeaders);
            break;
          case ApiRequestType.put:
            response = await http.put(url, body: body_, headers: httpHeaders);
            break;
          case ApiRequestType.delete:
            response = await http.delete(
              url,
              body: body_,
              headers: httpHeaders,
            );
            break;
        }

        if (printResult) {
          print(link);
          print(body);
          print(response.statusCode);
          log(response.body);
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (html) {
            return BaseApiObjectResponse<String>(response.body);
          } else {
            return BaseApiObjectResponse<T>.fromJson(
              jsonDecode(response.body),
              checkData: checkData,
            );
          }
        } else if (response.statusCode == 500) {
          throw Exception('somethingWentWrong'.tr);
        } else {
          throw Exception(
            jsonDecode(response.body)['message'] ?? 'somethingWentWrong'.tr,
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        if (snack) {
          showSnackBar(message: e.toString(), error: true);
        }
        return null;
      }
    }
  }

  Future<BaseApiObjectResponse?> formData<T>({
    required String link,
    ApiRequestType requestType = ApiRequestType.post,
    required Map<String, String> body,
    required Map<String, File?> files,
    bool printResult = false,
  }) async {
    bool error = false;

    /// Url
    var url = Uri.parse(link);
    var request = http.MultipartRequest(requestType.name.toUpperCase(), url);

    /// Headers
    for (var item in httpHeaders.keys.toList()) {
      request.headers[item] = httpHeaders[item] ?? '';
    }

    /// Files
    for (var item in files.keys.toList()) {
      if (files[item] != null) {
        http.MultipartFile file = await http.MultipartFile.fromPath(
          item,
          files[item]!.path,
        );
        request.files.add(file);
      }
    }

    /// Body
    for (var item in body.keys.toList()) {
      request.fields[item] = body[item] ?? '';
    }

    /// Response
    http.StreamedResponse streamedResponse;

    try {
      streamedResponse = await request.send();
    } catch (e) {
      error = true;
      return null;
    }

    var stringResponse = await streamedResponse.stream.bytesToString();

    if (printResult) {
      print('Link');
      print(link);
      print('Body Sent');
      print(body);
      print('Files Sent');
      print(request.files);
      print('Headers Sent');
      print(request.headers);
      print('Response Status Code');
      print(streamedResponse.statusCode);
      log(stringResponse);
    }

    if (streamedResponse.statusCode == 200 && !error) {
      return BaseApiObjectResponse<T>.fromJson(jsonDecode(stringResponse));
    } else if (streamedResponse.statusCode == 422 && !error) {
      return BaseApiObjectResponse<T>.fromJson(jsonDecode(stringResponse));
    }

    showSnackBar(message: 'somethingWentWrong'.tr, error: true);
    return null;
  }

  Future<BaseApiObjectResponse?> request2<T>({
    required String link,
    ApiRequestType requestType = ApiRequestType.post,
    required Map<String, dynamic> body,
    bool printResult = false,
  }) async {
    bool error = false;

    /// Url
    var url = Uri.parse(link);
    var request = http.Request(requestType.name.toUpperCase(), url);

    /// Headers
    for (var item in httpHeaders.keys.toList()) {
      request.headers[item] = httpHeaders[item] ?? '';
    }

    /// Body
    request.body = jsonEncode(body);

    /// Response
    http.StreamedResponse streamedResponse;

    try {
      streamedResponse = await request.send();
    } catch (e) {
      error = true;
      return null;
    }

    var stringResponse = await streamedResponse.stream.bytesToString();

    if (printResult) {
      print('Link');
      print(link);
      print('Body Sent');
      print(body);
      print('Headers Sent');
      print(request.headers);
      print('Response Status Code');
      print(streamedResponse.statusCode);
      log(stringResponse);
    }

    if (streamedResponse.statusCode == 200 && !error) {
      return BaseApiObjectResponse<T>.fromJson(jsonDecode(stringResponse));
    } else if (streamedResponse.statusCode == 422 && !error) {
      return BaseApiObjectResponse<T>.fromJson(jsonDecode(stringResponse));
    }

    return null;
  }
}
