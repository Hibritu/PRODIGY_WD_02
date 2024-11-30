
import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beautiful Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}


class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0"; // Displayed output
  String _output = ""; // Current input
  double num1 = 0; // First number
  double num2 = 0; // Second number
  String operand = ""; // Operation

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      // Reset all variables
      _output = "";
      output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      // Save the first number and operator
      num1 = double.parse(_output);
      operand = buttonText;
      _output = ""; // Clear input for the second number
    } else if (buttonText == "=") {
      // Perform the operation
      num2 = double.parse(_output);

      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "×":
          _output = (num1 * num2).toString();
          break;
        case "÷":
          _output = num2 != 0 ? (num1 / num2).toString() : "Error";
          break;
      }

      // Reset for the next operation
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      // Append number or decimal to input
      _output += buttonText;
    }

    // Update the displayed output
    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(24.0),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Beautiful Calculator"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          // Display
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Divider(color: Colors.white54),
          // Buttons
          Column(
            children: [
              Row(
                children: [
                  buildButton("7", Colors.blueGrey, Colors.white),
                  buildButton("8", Colors.blueGrey, Colors.white),
                  buildButton("9", Colors.blueGrey, Colors.white),
                  buildButton("÷", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.blueGrey, Colors.white),
                  buildButton("5", Colors.blueGrey, Colors.white),
                  buildButton("6", Colors.blueGrey, Colors.white),
                  buildButton("×", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.blueGrey, Colors.white),
                  buildButton("2", Colors.blueGrey, Colors.white),
                  buildButton("3", Colors.blueGrey, Colors.white),
                  buildButton("-", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton(".", Colors.blueGrey, Colors.white),
                  buildButton("0", Colors.blueGrey, Colors.white),
                  buildButton("C", Colors.red, Colors.white),
                  buildButton("+", Colors.orange, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton("=", Colors.green, Colors.white),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
