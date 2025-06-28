extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension StringUrlExtension on String {
  /// Converts a URL to a secure HTTPS URL if it starts with 'http://'.
  String secureUrl() {
    return startsWith('http://') ? replaceFirst('http://', 'https://') : this;
  }
}
