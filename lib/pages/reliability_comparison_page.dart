import 'package:flutter/material.dart';
import '../models/electricity_system_item.dart';
import '../models/reliability_comparison_result.dart';
import '../services/calculations.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class ReliabilityComparisonPage extends StatefulWidget {
  @override
  _ReliabilityComparisonPageState createState() => _ReliabilityComparisonPageState();
}

class _ReliabilityComparisonPageState extends State<ReliabilityComparisonPage> {
  Map<ElectricitySystemItem, int> selectedItems = {};

  ReliabilityComparisonCalculationResult? calculationResult;
  ElectricitySystemItem? dropdownValue;

  void _addSelectedItem(ElectricitySystemItem item) {
    setState(() {
      selectedItems[item] = (selectedItems[item] ?? 0) + 1;
    });
  }

  void _updateItemCount(ElectricitySystemItem item, int newCount) {
    setState(() {
      if (newCount <= 0) {
        selectedItems.remove(item);
      } else {
        selectedItems[item] = newCount;
      }
    });
  }

  void _calculateReliability() {
    setState(() {
      calculationResult = calculateReliability(selectedItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Виберіть елементи однофазної системи:"),
          SizedBox(height: 8),
          DropdownButton<ElectricitySystemItem>(
            isExpanded: true,
            value: dropdownValue,
            hint: Text("Додати елемент"),
            items: electricitySystemItemList.map((item) {
              return DropdownMenuItem<ElectricitySystemItem>(
                value: item,
                child: Text(item.name),
              );
            }).toList(),
            onChanged: (item) {
              if (item != null) {
                _addSelectedItem(item);
                setState(() {
                  dropdownValue = null;
                });
              }
            },
          ),
          SizedBox(height: 8),
          ...selectedItems.entries.map((entry) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.key.name),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _updateItemCount(entry.key, entry.value - 1),
                    ),
                    Text("${entry.value}"),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _updateItemCount(entry.key, entry.value + 1),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculateReliability,
            child: Text("Розрахувати надійність"),
          ),
          SizedBox(height: 16),
          if (calculationResult != null) ...[
            Text("Частота відмов одноколової системи: ${calculationResult!.totalFailureRateSingleCircuit.roundTo(4)}"),
            Text("Середня тривалість відновлення: ${calculationResult!.averageRestorationTime.roundTo(4)} год"),
            Text("Коефіцієнт аварійного простою: ${calculationResult!.accidentalOutageCoefficient.roundTo(4)}"),
            Text("Коефіцієнт планового простою: ${calculationResult!.plannedOutageCoefficient.roundTo(4)}"),
            Text("Частота одночасних відмов двоколової системи: ${calculationResult!.simultaneousFailureRateDoubleCircuit.roundTo(4)}"),
            Text("Загальна частота відмов двоколової системи: ${calculationResult!.totalFailureRateDoubleCircuit.roundTo(4)}"),
            Text(calculationResult!.comparisonResult),
          ],
        ],
      ),
    );
  }
}
