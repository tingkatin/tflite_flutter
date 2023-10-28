Map<String, double>? processOutput(
    Map<String, double>? classification, double threshold) {
  if (classification == null) {
    return null;
  }

  // PIPELINE: SORT | FILTER | TO PERCENT
  var sorted = sort(classification);
  var filtered = filter(sorted, threshold);
  var percentConverted = toPercent(filtered);
  return percentConverted;
}

Map<String, double> sort(Map<String, double> classification) {
  List<MapEntry<String, double>> sortedEntries = classification.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // Convert the sorted entries back to a map
  Map<String, double> sorted = Map.fromEntries(sortedEntries);

  return sorted;
}

Map<String, double> filter(
    Map<String, double> classification, double threshold) {
  Map<String, double> filtered = {};

  classification.forEach((key, value) {
    if (value > threshold) {
      filtered[key] = value;
    }
  });

  return filtered;
}

Map<String, double> toPercent(Map<String, double> classification) {
  Map<String, double> percentage = {};

  classification.forEach((key, value) {
    percentage[key] = value * 100;
  });

  return percentage;
}
