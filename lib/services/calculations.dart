import 'dart:math';
import '../models/interruption_loss_result.dart';
import '../models/reliability_comparison_result.dart';
import '../models/electricity_system_item.dart';
import '../utils/constants.dart';

// Розрахунок збитків від переривання електроенергії
InterruptionLossResult calculateInterruptionLoss({
  required double failureRate,
  required double averageRestorationTime,
  required double averageUnavailabilityTime,
  required double costPerKwhEmergency,
  required double costPerKwhPlanned,
  required double loadPower,
  required double annualOperationHours,
}) {
  double expectedUnavailabilityAccidental =
      failureRate * loadPower * annualOperationHours * averageRestorationTime;
  double expectedUnavailabilityPlanned =
      averageUnavailabilityTime * loadPower * annualOperationHours;
  double expectedFinancialLoss =
      (costPerKwhEmergency * expectedUnavailabilityAccidental) +
          (costPerKwhPlanned * expectedUnavailabilityPlanned);

  return InterruptionLossResult(
    expectedUnavailabilityAccidental: expectedUnavailabilityAccidental,
    expectedUnavailabilityPlanned: expectedUnavailabilityPlanned,
    expectedFinancialLoss: expectedFinancialLoss,
  );
}

// Розрахунок надійності системи
ReliabilityComparisonCalculationResult calculateReliability(
    Map<ElectricitySystemItem, int> selectedItems) {
  double totalFailureRateSingleCircuit = selectedItems.entries
      .map((entry) => entry.key.failureRate * entry.value)
      .fold(0.0, (prev, element) => prev + element);

  double weightedRestorationTimeSum = selectedItems.entries
      .map((entry) => entry.key.repairTime * entry.key.failureRate * entry.value)
      .fold(0.0, (prev, element) => prev + element);

  double averageRestorationTime = totalFailureRateSingleCircuit != 0
      ? weightedRestorationTimeSum / totalFailureRateSingleCircuit
      : 0.0;

  double accidentalOutageCoefficient =
      totalFailureRateSingleCircuit * averageRestorationTime / HOURS_IN_YEAR;
  double plannedOutageCoefficient = 1.2 * 43.0 / HOURS_IN_YEAR;

  double simultaneousFailureRateDoubleCircuit =
      2 * (totalFailureRateSingleCircuit * accidentalOutageCoefficient + plannedOutageCoefficient);
  double totalFailureRateDoubleCircuit = simultaneousFailureRateDoubleCircuit + 0.02;

  String comparisonResult;
  if (totalFailureRateSingleCircuit < totalFailureRateDoubleCircuit) {
    comparisonResult = "Надійність одноколової системи є вищою, ніж двоколової.";
  } else if (totalFailureRateSingleCircuit > totalFailureRateDoubleCircuit) {
    comparisonResult = "Надійність двоколової системи є вищою, ніж одноколової.";
  } else {
    comparisonResult = "Надійність обох систем рівна між собою.";
  }

  return ReliabilityComparisonCalculationResult(
    totalFailureRateSingleCircuit: totalFailureRateSingleCircuit,
    averageRestorationTime: averageRestorationTime,
    accidentalOutageCoefficient: accidentalOutageCoefficient,
    plannedOutageCoefficient: plannedOutageCoefficient,
    simultaneousFailureRateDoubleCircuit: simultaneousFailureRateDoubleCircuit,
    totalFailureRateDoubleCircuit: totalFailureRateDoubleCircuit,
    comparisonResult: comparisonResult,
  );
}
