final class StringToSearchOptions {
  factory StringToSearchOptions() => instance;

  StringToSearchOptions._internal();

  static final StringToSearchOptions instance = StringToSearchOptions._internal();

  List<String> convert(String string) {
    final List<String> result = <String>[];
    final List<String> words = string.split(' ');
    for (final String word in words) {
      final String lowerCaseWord = word.toLowerCase();
      final List<String> letters = lowerCaseWord.split('');
      String temp = '';
      for (final String letter in letters) {
        temp += letter;
        result.add(temp);
      }
    }
    return result;
  }
}
