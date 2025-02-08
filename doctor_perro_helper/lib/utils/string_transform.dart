/// Converts any duplicated word into word xNumber
String formatDuplicatedSentences(String input) {
  // Split the input string into sentences
  List<String> sentences = input.split(",").map((s) => s.trim()).toList();

  // Create a map to count occurrences of each sentence
  Map<String, int> sentenceCount = {};

  for (String sentence in sentences) {
    if (sentenceCount.containsKey(sentence)) {
      sentenceCount[sentence] = sentenceCount[sentence]! + 1;
    } else {
      sentenceCount[sentence] = 1;
    }
  }

  // Create the formatted output string
  List<String> result = [];
  sentenceCount.forEach((sentence, count) {
    if (count > 1) {
      result.add('$sentence x$count');
    } else {
      result.add(sentence);
    }
  });

  return result.join(", ");
}
