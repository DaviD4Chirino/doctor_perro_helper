import 'package:doctor_perro_helper/models/user_role.dart';

extension UserRoleExtension on UserRole {
  String toShortString() {
    return toString().split('.').last;
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere((e) => e.toShortString() == value);
  }

  // ? Maybe we are gonna need multiple languages, until then this works
  String translate() {
    switch (this) {
      case UserRole.admin:
        return "Administrador";
      case UserRole.employee:
        return "Empleado";
      default:
        return "Unknown";
    }
  }
}
