extension StringExtension on String {
  bool isValidEmail() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }

  String removeMessageHtmlTag() {
    return replaceAll('<p>', '').replaceAll('</p>', '');
  }

  String capitalize() {
    if (length > 3) {
      List<String> words = split(' ');
      for (int i = 0; i < words.length; i++) {
        words[i] = words[i].toLowerCase();
        if (words[i].isNotEmpty) {
          words[i] = words[i][0].toUpperCase() + words[i].substring(1);
        }
      }
      return words.join(' ');
    }
    return this;
  }
}

extension NullableStringExtension on String? {
  String removeMessageHtmlTag() {
    return (this ?? '').replaceAll('<p>', '').replaceAll('</p>', '');
  }

  String? capitalize() {
    if ((this?.length ?? 0) > 3) {
      List<String> words = (this ?? '').split(' ');
      for (int i = 0; i < words.length; i++) {
        words[i] = words[i].toLowerCase();
        if (words[i].isNotEmpty) {
          words[i] = words[i][0].toUpperCase() + words[i].substring(1);
        }
      }
      return words.join(' ');
    }
    return this;
  }
}
