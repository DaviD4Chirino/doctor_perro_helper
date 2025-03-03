import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/user_role.dart';
import 'package:doctor_perro_helper/utils/extensions/user_role_extensions.dart';

class UserDocument {
  UserDocument({
    required this.displayName,
    required this.email,
    this.creationTime,
    this.loginTime,
    this.ordersMade,
    this.uid = "no-uid",
    this.role = UserRole.employee,
  });

  String displayName;
  String email;

  String uid;
  DateTime? creationTime;
  DateTime? loginTime;
  List<MenuOrder>? ordersMade;

  /// use [UserRole] for a reference of what int means what role
  UserRole role;

  Map<String, dynamic> toJson() => {
        "display-name": displayName,
        "email": email,
        "creation-time": creationTime,
        "login-time": loginTime,
        "orders-made": ordersMade,
        "uid": uid,
        "role": role.toShortString(),
      };
  UserDocument.fromJson(Map<String, dynamic> json)
      : displayName = json["display-name"] as String,
        email = json['email'] as String,
        creationTime = (json["creation-time"] as Timestamp?)?.toDate(),
        loginTime = (json["login-time"] as Timestamp?)?.toDate(),
        ordersMade = json["orders-made"],
        uid = json["uid"] as String,
        role = UserRoleExtension.fromString(json["role"]);
}
