class BookingListModel {
  String? status;
  String? message;
  List<BookingData>? data;

  BookingListModel({this.status, this.message, this.data});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookingData>[];
      json['data'].forEach((v) {
        data!.add(new BookingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingData {
  int? id;
  int? userId;
  int? ambulanceId;
  String? description;
  double? latitude;
  double? longitude;
  DateTime? bookingTime;
  DateTime? arrivalTime;
  DateTime? completionTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  BookingData(
      {this.id,
      this.userId,
      this.ambulanceId,
      this.description,
      this.latitude,
      this.longitude,
      this.bookingTime,
      this.arrivalTime,
      this.completionTime,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    ambulanceId = json['ambulance_id'];
    description = json['description'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
    bookingTime = json['booking_time'] != null
        ? DateTime.parse(json['booking_time'])
        : null;
    arrivalTime = json['arrival_time'] != null
        ? DateTime.parse(json['arrival_time'])
        : null;
    completionTime = json['completion_time'] != null
        ? DateTime.parse(json['completion_time'])
        : null;
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['ambulance_id'] = this.ambulanceId;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['booking_time'] = this.bookingTime;
    data['arrival_time'] = this.arrivalTime;
    data['completion_time'] = this.completionTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? role;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.role,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
