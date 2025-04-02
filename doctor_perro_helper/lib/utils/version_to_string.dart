int versionStringToInt(String versionString) {
  // Remove the 'v' prefix if present
  String version = versionString.startsWith('v')
      ? versionString.substring(1)
      : versionString;

  // Split the version into its components
  List<String> components = version.split('.');

  // Ensure the version has major, minor, and patch components
  if (components.length != 3) {
    throw FormatException('Invalid semantic versioning format');
  }

  int major = int.parse(components[0]);
  int minor = int.parse(components[1]);
  int patch = int.parse(components[2]);

  // Combine the components into a single integer
  // Example: v0.5.0 -> 005000 (assuming major, minor, patch are 2 digits each)
  return major * 1000000 + minor * 1000 + patch;
}
