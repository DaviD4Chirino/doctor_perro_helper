import 'package:doctor_perro_helper/models/order/order.dart';
import 'package:doctor_perro_helper/models/user_role.dart';

class UserAccount {
  UserAccount({
    required this.displayName,
    required this.email,
    this.creationTime,
    this.loginTime,
    this.role,
    this.ordersMade,
  });

  String displayName = "noDisplayName";
  String email = "no@email.com";

  DateTime? creationTime;
  DateTime? loginTime;
  List<Order>? ordersMade;

  /// use [UserRole] for a reference of what int means what role
  UserRole? role = UserRole.customer;

  Map<String, dynamic> toJson() => {
        "display.name": displayName,
        "email": email,
        "creation-time": creationTime,
        "login-time": loginTime,
        "orders-made": ordersMade,
      };

  UserAccount fromJson(Map<String, dynamic> json) {
    return UserAccount(
      displayName: json["display-name"],
      email: json["email"],
      creationTime: json["creation-time"],
      loginTime: json["login-time"],
      ordersMade: json["orders-made"],
    );
  }
}
