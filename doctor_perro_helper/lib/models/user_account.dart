import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/order/order.dart';
import 'package:doctor_perro_helper/models/user_role.dart';

class UserDocument {
  UserDocument({
    required this.displayName,
    required this.email,
    this.creationTime,
    this.loginTime,
    this.role,
    this.ordersMade,
  });

  String displayName;
  String email;

  /// This should never be messed with manually
  String uid = "no-uid";
  DateTime? creationTime;
  DateTime? loginTime;
  List<MenuOrder>? ordersMade;

  /// use [UserRole] for a reference of what int means what role
  UserRole? role = UserRole.employee;

  Map<String, dynamic> toJson() => {
        "display-name": displayName,
        "email": email,
        "creation-time": creationTime,
        "login-time": loginTime,
        "orders-made": ordersMade,
        "uid": uid,
        "role": role?.toShortString(),
      };
  UserDocument.fromJson(Map<String, dynamic> json)
      : displayName = json["display-name"] as String,
        email = json['email'] as String,
        creationTime = (json["creation-time"] as Timestamp?)?.toDate(),
        loginTime = (json["login-time"] as Timestamp?)?.toDate(),
        ordersMade = json["orders-made"],
        uid = json["uid"] as String,
        role = json["role"] != null
            ? UserRoleExtension.fromString(json["role"])
            : null;
}
