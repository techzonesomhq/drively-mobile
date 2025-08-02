class UserModel {
  int? id;
  String? image;
  String? name;
  String? code;
  String? mobile;
  String? dialCode;
  String? mobileNumber;
  int? collageId;
  String? collage;
  bool? isDeleted;
  String? type;
  int? governorateId;
  String? governorate;
  int? areaId;
  String? area;
  int? squareId;
  String? square;
  num? lat;
  num? lon;

  UserModel({
    this.id,
    this.image,
    this.name,
    this.code,
    this.mobile,
    this.dialCode,
    this.mobileNumber,
    this.collageId,
    this.collage,
    this.isDeleted,
    this.type,
    this.governorateId,
    this.governorate,
    this.areaId,
    this.area,
    this.squareId,
    this.square,
    this.lat,
    this.lon,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    code = json['code'];
    mobile = json['mobile'];
    dialCode = json['dial_code'];
    mobileNumber = json['mobile_number'];
    collageId = json['collage_id'];
    collage = json['collage'];
    isDeleted = json['is_deleted'];
    type = json['type'];
    governorateId = json['governorate_id'];
    governorate = json['governorate'];
    areaId = json['area_id'];
    area = json['area'];
    squareId = json['square_id'];
    square = json['square'];
    lat = json['lat'] ?? 0;
    lon = json['lon'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['image'] = image;
    json['name'] = name;
    json['code'] = code;
    json['mobile'] = mobile;
    json['dialCode'] = dialCode;
    json['mobileNumber'] = mobileNumber;
    json['collageId'] = collageId;
    json['collage'] = collage;
    json['isDeleted'] = isDeleted;
    json['type'] = type;
    json['governorateId'] = governorateId;
    json['governorate'] = governorate;
    json['areaId'] = areaId;
    json['area'] = area;
    json['squareId'] = squareId;
    json['square'] = square;
    json['lat'] = lat;
    json['lon'] = lon;
    return json;
  }
}
