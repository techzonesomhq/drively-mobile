class IdNameModel {
  int? id;
  String? name;
  String? image;
  String? key;

  IdNameModel({this.id, this.name, this.image, this.key});

  IdNameModel.fromJson(Map<String, dynamic> json) {
    id = (json['id']) is String ? int.parse(json['id']) : json['id'];
    name = json['title'] ?? json['name'];
    image = json['image'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['key'] = key;
    return json;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is IdNameModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              key == other.key;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ key.hashCode;
}
