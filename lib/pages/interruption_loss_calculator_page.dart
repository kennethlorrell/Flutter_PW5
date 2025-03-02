import 'package:flutter/material.dart';
import '../models/interruption_loss_result.dart';
import '../services/calculations.dart';
import '../utils/helpers.dart';

class InterruptionLossCalculatorPage extends StatefulWidget {
  @override
  _InterruptionLossCalculatorPageState createState() => _InterruptionLossCalculatorPageState();
}

class _InterruptionLossCalculatorPageState extends State<InterruptionLossCalculatorPage> {
  final TextEditingController failureRateController = TextEditingController(text: "0.01");
  final TextEditingController avgRestorationTimeController = TextEditingController(text: "0.045");
  final TextEditingController avgUnavailabilityTimeController = TextEditingController(text: "0.004");
  final TextEditingController costPerKwhEmergencyController = TextEditingController(text: "23.6");
  final TextEditingController costPerKwhPlannedController = TextEditingController(text: "17.6");
  final TextEditingController loadPowerController = TextEditingController(text: "5120");
  final TextEditingController annualOperationHoursController = TextEditingController(text: "6451");

  InterruptionLossResult? result;

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  void _calculate() {
    setState(() {
      result = calculateInterruptionLoss(
        failureRate: double.parse(failureRateController.text),
        averageRestorationTime: double.parse(avgRestorationTimeController.text),
        averageUnavailabilityTime: double.parse(avgUnavailabilityTimeController.text),
        costPerKwhEmergency: double.parse(costPerKwhEmergencyController.text),
        costPerKwhPlanned: double.parse(costPerKwhPlannedController.text),
        loadPower: double.parse(loadPowerController.text),
        annualOperationHours: double.parse(annualOperationHoursController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Введіть параметри ГПП:"),
          buildTextField(failureRateController, "Частота відмов"),
          buildTextField(avgRestorationTimeController, "Середній час відновлення"),
          buildTextField(avgUnavailabilityTimeController, "Середній час планового простою"),
          buildTextField(costPerKwhEmergencyController, "Питомі збитки (аварійні)"),
          buildTextField(costPerKwhPlannedController, "Питомі збитки (планові)"),
          buildTextField(loadPowerController, "Навантаження"),
          buildTextField(annualOperationHoursController, "Річні години роботи"),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculate,
            child: Text("Розрахувати збитки"),
          ),
          SizedBox(height: 16),
          if (result != null) ...[
            Text("Аварійне недопущення: ${result!.expectedUnavailabilityAccidental.roundTo(2)} кВт·год"),
            Text("Планове недопущення: ${result!.expectedUnavailabilityPlanned.roundTo(2)} кВт·год"),
            Text("Збитки від переривання: ${result!.expectedFinancialLoss.roundTo(2)} грн"),
          ],
        ],
      ),
    );
  }
}
