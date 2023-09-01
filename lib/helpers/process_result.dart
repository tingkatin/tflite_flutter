Map<String, double>? processOutput(Map<String, double>? classification) {
  if (classification == null) {
    return null;
  }

  // PIPELINE: SORT | FILTER | TO PERCENT
  var sorted = sort(classification);
  var filtered = filter(sorted, 4, 0.0);
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
    Map<String, double> classification, int limit, double threshold) {
  Map<String, double> filtered = {};
  int count = 0;

  classification.forEach((key, value) {
    if (value > threshold && count < limit) {
      filtered[key] = value;
      count++;
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
