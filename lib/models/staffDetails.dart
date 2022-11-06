import 'dart:convert';

List<StaffDetails> staffDetailsFromJson(String str) => List<StaffDetails>.from(
    json.decode(str).map((x) => StaffDetails.fromJson(x)));

String staffDetailsToJson(List<StaffDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffDetails {
  StaffDetails({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.imageDp,
    required this.department,
  });

  String id;
  String name;
  String age;
  String phone;
  String imageDp;
  String department;

  factory StaffDetails.fromJson(Map<String, dynamic> json) => StaffDetails(
        id: json['_id'],
        name: json["name"],
        age: json["age"],
        phone: json["phone"],
        imageDp: json["imageDp"],
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "phone": phone,
        "imageDp": imageDp,
        "department": department,
      };
}
