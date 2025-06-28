extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String secureUrl() {
    // Replace 'http://' with 'https://' if it starts with 'http://'
    return startsWith('http://') ? replaceFirst('http://', 'https://') : this;
  }
}
