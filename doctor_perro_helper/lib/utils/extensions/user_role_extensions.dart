import 'package:doctor_perro_helper/models/user_role.dart';

extension UserRoleExtension on UserRole {
  String toShortString() {
    return toString().split('.').last;
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere((e) => e.toShortString() == value);
  }
}
