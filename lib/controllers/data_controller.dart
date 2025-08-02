import 'package:app/models/api/id_name_model.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  /// Categories
  List<IdNameModel> _categories = [];

  List<IdNameModel> get categories => _categories;

  set categories(List<IdNameModel> __) => [_categories = __, update()];
}
