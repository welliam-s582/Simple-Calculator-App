import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: Scaffold(
        appBar: AppBar(
          title: Text("MyCalculator"),
        ),
        body: Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String output_temp = "0";
  String operand = "";
  double num1 = 0.0;
  double num2 = 0.0;

  buttonPressed(String buttonVal) {
    if (buttonVal == "Clear") {
      num1 = 0.0;
      num2 = 0.0;
      output_temp = "0";
      operand = "";
    } else if (buttonVal == '+' ||
        buttonVal == '-' ||
        buttonVal == 'x' ||
        buttonVal == '÷') {
      num1 = double.parse(output);
      operand = buttonVal;
      output_temp = buttonVal;
    } else if (buttonVal == '.') {
      if (!output_temp.contains('.')) {
        output_temp = output_temp + buttonVal;
      }
    } else if (buttonVal == '=') {
      num2 = double.parse(output);
      if (operand == '+') {
        output_temp = (num1 + num2).toString();
      }
      if (operand == '-') {
        output_temp = (num1 - num2).toString();
      }
      if (operand == 'x') {
        output_temp = (num1 * num2).toString();
      }
      if (operand == '÷') {
        output_temp = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      if (output_temp == operand) {
        output_temp = '0';
      }
      output_temp = output_temp + buttonVal;
    }

    setState(() {
      if (output_temp.contains('.')) {
        var decimal_length = output_temp.split('.')[1];
        if (decimal_length.length == 1 && decimal_length == '0') {
          output = double.parse(output_temp).toInt().toString();
          output_temp = output_temp.split('.')[0];
        } else {
          output = double.parse(output_temp).toString();
        }
      } else if (output_temp == operand) {
        output = output_temp;
      } else {
        output = int.parse(output_temp).toString();
      }
    });
  }

  Widget buttons(String buttonVal) {
    return Expanded(
      child: ElevatedButton(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 48.5, horizontal: 0.0),
          child: Text(
            buttonVal,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () {
          buttonPressed(buttonVal);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
          child: Text(
            output,
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(),
        Column(
          children: [
            Row(
              children: [
                buttons('7'),
                buttons('8'),
                buttons('9'),
                buttons('÷'),
              ],
            ),
            Row(
              children: [
                buttons('4'),
                buttons('5'),
                buttons('6'),
                buttons('x'),
              ],
            ),
            Row(
              children: [
                buttons('1'),
                buttons('2'),
                buttons('3'),
                buttons('-'),
              ],
            ),
            Row(
              children: [
                buttons('.'),
                buttons('0'),
                buttons('00'),
                buttons('+'),
              ],
            ),
            Row(
              children: [
                buttons("Clear"),
                buttons('='),
              ],
            )
          ],
        )
      ]),
    );
  }
}
