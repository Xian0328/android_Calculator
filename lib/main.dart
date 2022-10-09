import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CalculateApp());
}

class CalculateApp extends StatelessWidget {
  const CalculateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculate(),
    );
  }
}

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {

  Calculation cal = Calculation();

  Widget calcbutton(String btnText, Color btncolor, Color txtcolor){
    return Container(
      child: new SizedBox(
        width: 80.0,
        height: 80.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            primary: btncolor,
            padding: EdgeInsets.all(10),
          ),
          onPressed: (){
            setState(() {
              result = cal.buttonPressed(btnText);
            });
          },
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 30,
              color: txtcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }
  String result = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("計算機"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children :[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  cal.resultOperationText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              ],
            ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Padding(
                   padding: EdgeInsets.all(10.0),
                   child: Text(
                     result,
                     textAlign: TextAlign.left,
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 60,
                     ),
                   ),
                 )
               ],
             ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('AC', Colors.grey, Colors.black),
                calcbutton('+/-', Colors.grey, Colors.black),
                calcbutton('%', Colors.grey, Colors.black),
                calcbutton('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('7', Color(0xff424242), Colors.white),
                calcbutton('8', Color(0xff424242), Colors.white),
                calcbutton('9', Color(0xff424242), Colors.white),
                calcbutton('X', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('4', Color(0xff424242), Colors.white),
                calcbutton('5', Color(0xff424242), Colors.white),
                calcbutton('6', Color(0xff424242), Colors.white),
                calcbutton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('1', Color(0xff424242), Colors.white),
                calcbutton('2', Color(0xff424242), Colors.white),
                calcbutton('3', Color(0xff424242), Colors.white),
                calcbutton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    primary: Color(0xff424242),
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                  onPressed: (){
                    setState(() {
                      result = cal.buttonPressed("0");
                    });
                  },
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                calcbutton('.', Color(0xff424242), Colors.white),
                calcbutton('=', Colors.amber.shade700, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Calculation{
  String output = "0";
  String output2 = "0";
  String _output = "";

  dynamic num1 = 0;
  dynamic num2 = 0;
  String opr = "";
  String resultOperationText = "";
  bool isPressedPercentageButton = true;

  String buttonPressed(String btntxt){
    if (btntxt == "AC"){
      _output = "";
      num1 = 0;
      num2 = 0;
      opr = "";
      output = "0";
      resultOperationText = "";
      isPressedPercentageButton = true;

      return output;
    }
    else if(btntxt == "+/-"){
      isPressedPercentageButton = true;

      if(_output.startsWith("-",0)){
        _output = _output.replaceAll("-", "");
        output = _output;
        resultOperationText = output;
      }
      else{
        if(_output == ""){
          _output = "0";
          _output = "-" + _output;
          output = _output;
          resultOperationText = output;
        }
        else{
          _output = "-" + _output;
          output = _output;
          resultOperationText = output;
        }
      }
      return output;
    }
    else if(btntxt == "%"){
      if(isPressedPercentageButton){
        if(output.contains(".")){
          num1 = double.parse(output);
        }
        else{
          num1 = int.parse(output);
        }
        //print(num1);

        _output = (num1 / 100).toString();
        //print(_output.length);
        if(_output.length > 9){
          output = double.parse(_output).toStringAsFixed(num1.toString().length);
        }
        else{
          output = double.parse(_output).toString();
        }
        _output = "";
        num1 = 0;
        resultOperationText = output;
        return output;
      }
    }
    else if(btntxt == "+" ||
        btntxt == "-" ||
        btntxt == "X"||
        btntxt == "/"
    ){
      if(output.contains(".")){
        num1 = double.parse(output);
      }
      else{
        num1 = int.parse(output);
      }
      opr = btntxt;
      resultOperationText = opr;
      output = "0";
      isPressedPercentageButton = false;
      //print(opr);
      _output = "";
    }
    else if(btntxt == "."){
      if(_output.contains(".")){
        _output = _output + "";
        output = _output;
        resultOperationText = output;
      }
      else{
        if(output == "0"){
          _output = output + btntxt;
          output = _output;
          resultOperationText = output;
        }
        else{
          _output = _output + btntxt;
          output = _output;
          resultOperationText = output;
        }
      }
    }
    else if(btntxt == "="){
      isPressedPercentageButton = true;
      if(output.contains(".")){
        num2 = double.parse(output);
      }
      else{
        num2 = int.parse(output);
      }

      if(opr == "+"){
        _output = (num1 + num2).toString();
      }
      if(opr == "-"){
        _output = (num1 - num2).toString();
      }
      if(opr == "X"){
        _output = (num1 * num2).toString();
      }
      if(opr == "/"){
        if(num2 == 0){
          _output = "Error";
        }
        else{
          if(num1 % num2 == 0){
            _output = (num1 ~/ num2).toString();
          }
          else{
            _output = (num1 / num2).toString();
          }
        }
      }

      num1 = 0;
      num2 = 0;
      opr = "";
      if(_output.contains(".")){
        if(_output.length >=9){
          output = double.parse(_output).toStringAsFixed(9);
        }
        else{
          output = double.parse(_output).toStringAsFixed(_output.length-2);
        }
      }
      else{
        output = _output;
      }
      resultOperationText = output;
      _output = "";
    }
    else{
      if(_output.contains(".") == false){
        if(_output.startsWith("-0") ||  _output.startsWith("0")){
          _output = _output.replaceFirst("0", "") + btntxt;
          output = _output;
          resultOperationText = resultOperationText + btntxt;
        }
        else{
          _output = _output + btntxt;
          output = _output;
          resultOperationText = resultOperationText + btntxt;
        }
      }
      else{
        _output = _output + btntxt;
        output = _output;
        resultOperationText = resultOperationText + btntxt;
      }
    }
    return output;
  }
}
