
import 'package:calculator/button_nums.dart';
import 'package:flutter/material.dart';
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 =
      ""; // we are adding this to give it how to take inputs and to avoid a stationary integer(dynamic)
  String operand = "";
  String number2 = ""; 

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(
      context,
    ).size; //it's changing the size according to the need
    return Scaffold(
      
      body: SafeArea(
        bottom: false, //
        child: Column(
          children: [
            Expanded(
              // it's used to expand the screen by allowing single child to scroll
              child: SingleChildScrollView(
                reverse:
                    true, //reverse helps in changing it from top to bottom to maintain readability
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "$number1$operand$number2".isEmpty
                          ? "0"
                          : "$number1$operand$number2", //$ is used to assign vars, identi, etc.
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),

            Wrap(
              //used for multiple btns within a similar area?
              children: Btn.buttonNums
                  .map(
                    (value) => SizedBox(
                      width: value == Btn.calculate 
                          ? screenSize.width / 2
                          : (screenSize.width /
                                4), //[] can contain multiple constrainst
                      height:
                          screenSize.width /
                          5, //it's using the condition to assign the width respectively, same could be done for height
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value), // it's used as a fn to get the colors
        clipBehavior: Clip.hardEdge, //to keep the splash effect within the btn
        shape: OutlineInputBorder(
          //to give the border for the nums
          borderSide: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          //splash effect
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ), //gets the value to be centred
        ),
      ),
    );
  } //most of the functions are written here


// ###############
  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
    }

    if(value==Btn.per){
      convertToPercentage();
      return;
    }

    if(value==Btn.calculate){
      calculate();
      return;
    }

    appendValue(value);
  }


// ############
  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }


  // ##############
  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(
        0,
        number2.length - 1,
      ); // it s used to delete from the end
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }


  void calculate(){
    if(operand.isEmpty) return;
    if(number1.isEmpty) return;
    if(number2.isEmpty) return;

    double num1 = double.parse(number1);    // we use double.parse to convert the string to a decimal to further carry out operations
    double num2 = double.parse(number2);

    var result = 0.0; 
    switch(operand){
      case Btn.add:
        result = num1 + num2;
      break;
      case Btn.divide:
        result = num1 / num2;
      break;
      case Btn.multiply:
        result = num1 * num2;
      break;
      case Btn.subtract:
        result = num1 - num2;
       
      break;
    default:
    }
    setState(() {
      number1 = "$result";

      if(number1.endsWith(".0" )){
        number1 = number1.substring(0, number1.length -2);
      }

      operand = "";
      number2 = "";
    });
  }


//####################
  void convertToPercentage(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
      calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number/100)}";
      operand = "";
      number2 = "";
    });
  }
     


  // #######################
  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      //setting the parsing method for decision making
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate();
      }
      operand = value;
    }

     else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        value = "0";
      }
      number1 += value;
    }

     else if (number2.isEmpty || operand.isNotEmpty) {
      //operand is not empty the same as num1 shouldn't be empty to proceed
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        value = "0";
      }
      number2 += value;
    }

    setState(() {
      //set state is used to predefine a fn for the rest of its similar operation
    });
  }


  // ###############
  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.amberAccent
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
          ].contains(value)
        ? Colors.amber
        : const Color.fromARGB(199, 0, 0, 0);
  }
}
