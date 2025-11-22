import 'package:flutter/material.dart';

class Score extends ChangeNotifier {
  int totalScore = 0;
  int? selectedEndDistance;
  int? selectedEndPoints;
  String? selectedTeam;
  int penalties = 0;
  int assemblyCount = 0;
  int ovenCount = 0;
  int hatchCount = 0;

  void addAssembly() {
    assemblyCount += 1;
    totalScore += 3;
    notifyListeners();
  }

  void addOven() {
    ovenCount += 1;
    totalScore += 5;
    notifyListeners();
  }

  void addHatch() {
    hatchCount += 1;
    totalScore += 8;
    notifyListeners();
  }

  void addPoints(int pts) {
    totalScore += pts;
    notifyListeners();
  }

  void subtractPoints(int pts) {
    totalScore -= pts;
    notifyListeners();
  }

  void addPenalty(int pts) {
    totalScore -= pts;
    penalties += 1;
    notifyListeners();
  }

  void selectEndDistance(int distance, int points) {
    // if a previous selection existed this remove its points first
    if (selectedEndPoints != null) {
      totalScore -= selectedEndPoints!;
    }

    // sets the new selection
    selectedEndDistance = distance;
    selectedEndPoints = points;

    // adds the new points
    totalScore += points;

    notifyListeners();
  }

  void setTeam(String team) {
    selectedTeam = team;
    notifyListeners();
  }

  Map<String, dynamic> exportData() { // holds all the values that is getting exported in a map
    return {
      'team': selectedTeam,
      'totalScore': totalScore,
      'endDistance': selectedEndDistance,
      'penalties': penalties,
      'assembly': assemblyCount,
      'oven': ovenCount,
      'hatch': hatchCount,
    };
  }

  void resetAll() {
    totalScore = 0;
    selectedTeam = null;
    selectedEndDistance = null;
    selectedEndPoints = null;

    penalties = 0;
    assemblyCount = 0;
    ovenCount = 0;
    hatchCount = 0;

    notifyListeners();
  }

}
