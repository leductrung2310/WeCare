enum BMIStatus {
  underweight,
  normal,
  overweight,
}

class BMIRatio {
  double ratio;
  BMIStatus status;
  DateTime updatedDate;

  BMIRatio({
    required this.ratio,
    required this.status,
    required this.updatedDate,
  });

  set setBMIRatio(newValue) {
    ratio = newValue;
  }
  get getBMIRatio => ratio;

  set setBMIStatus(newValue) {
    status = newValue;
  }
  get getBMIStatus => status;

  set setBMIUpdatedDate(newValue) {
    updatedDate = newValue;
  }
  get getBMIUpdatedDate => updatedDate;
}

class BMIRatioHistory {
  List<BMIRatio> bmiRatioHistoryList;

  BMIRatioHistory({required this.bmiRatioHistoryList});

  set setBMIRatioHistoryList(newValue){
    bmiRatioHistoryList = newValue;
  }

  get getRatioHistoryList => bmiRatioHistoryList;
}
