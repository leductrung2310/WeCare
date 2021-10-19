enum BMIState {
  underweight,
  normal,
  overweight,
}

class BMIHistory {
  final double ratio;
  final BMIState state;
  final DateTime date;

  BMIHistory({
    required this.ratio,
    required this.state,
    required this.date,
  });
}

List<BMIHistory> bmiData = [
  BMIHistory(ratio: 21.7, state: BMIState.normal, date: DateTime.now()),
  BMIHistory(ratio: 18.0, state: BMIState.underweight, date: DateTime.now()),
  BMIHistory(ratio: 32, state: BMIState.overweight, date: DateTime.now()),
];
