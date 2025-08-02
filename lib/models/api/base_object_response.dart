import 'package:app/models/api/base_response.dart';
import 'package:app/models/api/id_name_model.dart';
import 'package:app/models/api/user/user_model.dart';

class BaseApiObjectResponse<T> extends BaseApiResponse {
  late T? body;

  BaseApiObjectResponse(this.body);

  BaseApiObjectResponse.fromJson(dynamic json, {bool checkData = true})
    : super.fromJson(json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('data') && checkData) {
        /// -- ITEM --
        if (T == UserModel) {
          /// User Model
          body = UserModel.fromJson(json['data'] ?? {}) as T;
        }
        /// -- ITEMS --
        else if (T == List<IdNameModel>) {
          /// Id Name Model
          var jsonList = json['data'] as List;
          body = jsonList.map((e) => IdNameModel.fromJson(e)).toList() as T;
        } else if (T == String) {
          body = json['data'];
        } else if (T == int) {
          body = json['data'];
        }
      } else {
        /// -- ITEM --
        if (T == UserModel) {
          /// User Model
          body = UserModel.fromJson(json) as T;
        }
      }
    } else {
      body = null;
    }
  }
}
