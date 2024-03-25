class UserModel {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? role;
  String? createdAt;
  String? updatedAt;
  Ambulance? ambulance;

  UserModel(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.ambulance});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ambulance = json['ambulance'] != null
        ? new Ambulance.fromJson(json['ambulance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ambulance != null) {
      data['ambulance'] = this.ambulance!.toJson();
    }
    return data;
  }
}

class Ambulance {
  int? id;
  int? userId;
  String? licensePlate;
  String? model;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? updatedAt;

  Ambulance(
      {this.id,
      this.userId,
      this.licensePlate,
      this.model,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  Ambulance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    licensePlate = json['license_plate'];
    model = json['model'];
    latitude = double.parse(json['latitude'].toString());
    longitude = double.parse(json['longitude'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['license_plate'] = this.licensePlate;
    data['model'] = this.model;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
