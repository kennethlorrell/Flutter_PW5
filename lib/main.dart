import 'package:flutter/material.dart';
import 'pages/reliability_comparison_page.dart';
import 'pages/interruption_loss_calculator_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ReliabilityComparisonPage(),
    InterruptionLossCalculatorPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildAppBarActions() {
    return Row(
      children: [
        TextButton(
          onPressed: () => _onTabTapped(0),
          child: Text(
            'Завдання 1',
            style: TextStyle(
              color: _selectedIndex == 0 ? Colors.black : Colors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _onTabTapped(1),
          child: Text(
            'Завдання 2',
            style: TextStyle(
              color: _selectedIndex == 1 ? Colors.black : Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор для порівняння надійності систем електропередачі'),
        actions: [_buildAppBarActions()],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
