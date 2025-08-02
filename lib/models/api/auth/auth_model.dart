import 'package:app/models/api/user/user_model.dart';

class AuthModel {
  String? token;
  UserModel? user;
  String? status;

  AuthModel({this.token, this.user, this.status});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    status = json['status'];
  }
}
