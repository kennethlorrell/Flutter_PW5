import '../models/electricity_system_item.dart';

const double HOURS_IN_YEAR = 8760;

final List<ElectricitySystemItem> electricitySystemItemList = [
  ElectricitySystemItem(name: "ПЛ-110 кВ", failureRate: 0.07, repairTime: 10.0, outageRate: 0.167, avgRepairTime: 35.0),
  ElectricitySystemItem(name: "ПЛ-35 кВ", failureRate: 0.02, repairTime: 8.0, outageRate: 0.167, avgRepairTime: 35.0),
  ElectricitySystemItem(name: "ПЛ-10 кВ", failureRate: 0.02, repairTime: 10.0, outageRate: 0.167, avgRepairTime: 35.0),
  ElectricitySystemItem(name: "КЛ-10 кВ (траншея)", failureRate: 0.03, repairTime: 44.0, outageRate: 1.0, avgRepairTime: 9.0),
  ElectricitySystemItem(name: "КЛ-10 кВ (кабельний канал)", failureRate: 0.005, repairTime: 17.5, outageRate: 1.0, avgRepairTime: 9.0),
  ElectricitySystemItem(name: "Т-110 кВ", failureRate: 0.015, repairTime: 100.0, outageRate: 1.0, avgRepairTime: 43.0),
  ElectricitySystemItem(name: "Т-35 кВ", failureRate: 0.02, repairTime: 80.0, outageRate: 1.0, avgRepairTime: 28.0),
  ElectricitySystemItem(name: "Т-10 кВ (кабельна мережа)", failureRate: 0.005, repairTime: 60.0, outageRate: 0.5, avgRepairTime: 10.0),
  ElectricitySystemItem(name: "Т-10 кВ (повітряна мережа)", failureRate: 0.01, repairTime: 30.0, outageRate: 1.0, avgRepairTime: 30.0),
  ElectricitySystemItem(name: "В-110 кВ (елегазовий)", failureRate: 0.01, repairTime: 40.0, outageRate: 0.33, avgRepairTime: 15.0),
  ElectricitySystemItem(name: "В-10 кВ (малооливний)", failureRate: 0.02, repairTime: 15.0, outageRate: 0.33, avgRepairTime: 15.0),
  ElectricitySystemItem(name: "В-10 кВ (вакуумний)", failureRate: 0.02, repairTime: 10.0, outageRate: 0.33, avgRepairTime: 15.0),
  ElectricitySystemItem(name: "Збірні шини 10 кВ на 1 приєднання", failureRate: 0.03, repairTime: 2.0, outageRate: 0.167, avgRepairTime: 5.0),
  ElectricitySystemItem(name: "АВ-0,38 кВ", failureRate: 0.05, repairTime: 4.0, outageRate: 0.33, avgRepairTime: 10.0),
  ElectricitySystemItem(name: "ЕД 6, 10 кВ", failureRate: 0.1, repairTime: 160.0, outageRate: 0.5, avgRepairTime: 0.0),
  ElectricitySystemItem(name: "ЕД 0,38 кВ", failureRate: 0.1, repairTime: 50.0, outageRate: 0.5, avgRepairTime: 0.0),
];