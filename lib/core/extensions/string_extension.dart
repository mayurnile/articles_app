extension StringExtensions on String {
  /// Capitalizes the first letter of a string and keeps the rest lowercase
  ///
  /// Example: 'hello world' -> 'Hello world'
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
