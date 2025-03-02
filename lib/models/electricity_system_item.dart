class ElectricitySystemItem {
  final String name;
  final double failureRate;
  final double repairTime;
  final double outageRate;
  final double avgRepairTime;

  ElectricitySystemItem({
    required this.name,
    required this.failureRate,
    required this.repairTime,
    required this.outageRate,
    required this.avgRepairTime,
  });
}
