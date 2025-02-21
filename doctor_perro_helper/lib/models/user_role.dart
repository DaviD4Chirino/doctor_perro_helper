enum UserRole {
  unknown,
  employee,
  admin,
}

extension UserRoleExtension on UserRole {
  String toShortString() {
    return toString().split('.').last;
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere((e) => e.toShortString() == value);
  }
}
