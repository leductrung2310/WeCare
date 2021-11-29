class NutritionHistory {
  String? nutrition1;
  String? nutrition2;
  String? nutrition3;
  String? nutrition4;
  String? nutrition5;
  // String? nutrition6;
  // String? nutrition7;
  // String? nutrition8;
  // String? nutrition9;
  // String? nutrition10;

  NutritionHistory({
    required this.nutrition1,
    required this.nutrition2,
    required this.nutrition3,
    required this.nutrition4,
    required this.nutrition5,
    // required this.nutrition6,
    // required this.nutrition7,
    // required this.nutrition8,
    // required this.nutrition9,
    // required this.nutrition10,
  });

  NutritionHistory.fromMap(Map<String, dynamic> map) {
    nutrition1 = map['1'];
    nutrition2 = map['2'];
    nutrition3 = map['3'];
    nutrition4 = map['4'];
    nutrition5 = map['5'];
    // nutrition6: map['nutrition6'],
    // nutrition7: map['nutrition7'],
    // nutrition8: map['nutrition8'],
    // nutrition9: map['nutrition9'],
    // nutrition10: map['nutrition10'],
  }

  Map<String, dynamic> toMap() {
    return {
      'nutrition1': nutrition1,
      'nutrition2': nutrition2,
      'nutrition3': nutrition3,
      'nutrition4': nutrition4,
      'nutrition5': nutrition5,
      // 'nutrition6': nutrition6,
      // 'nutrition7': nutrition7,
      // 'nutrition8': nutrition8,
      // 'nutrition9': nutrition9,
      // 'nutrition10': nutrition10,
    };
  }
}
