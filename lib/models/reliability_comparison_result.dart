class ReliabilityComparisonCalculationResult {
  final double totalFailureRateSingleCircuit;
  final double averageRestorationTime;
  final double accidentalOutageCoefficient;
  final double plannedOutageCoefficient;
  final double simultaneousFailureRateDoubleCircuit;
  final double totalFailureRateDoubleCircuit;
  final String comparisonResult;

  ReliabilityComparisonCalculationResult({
    required this.totalFailureRateSingleCircuit,
    required this.averageRestorationTime,
    required this.accidentalOutageCoefficient,
    required this.plannedOutageCoefficient,
    required this.simultaneousFailureRateDoubleCircuit,
    required this.totalFailureRateDoubleCircuit,
    required this.comparisonResult,
  });
}
