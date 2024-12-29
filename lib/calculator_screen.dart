 

import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1="";// . 0-9
  String operand="";// + - x ÷ %
  String number2=""; // . 0-9 


  @override
  Widget build(BuildContext context) {
     final screenSize=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          //output
        Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const  EdgeInsets.all(16),
              child: Text("$number1$operand$number2".isEmpty ? "0":"$number1$operand$number2",
               style: TextStyle(
                fontSize: 48 ,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.end,),
            ),
          ),
        ),
        
          //button
          Wrap(
           children:Btn.buttonvalues.map(
            (value)=>SizedBox (
              width:value== Btn.n0 ?screenSize.width/2:(screenSize.width/4),
              height:screenSize.height/7,
              child: buildButton(value)
           ),
           )
           .toList(),
        )
        ]),
      ) ,
      );
  }

  //#####
  Widget buildButton(value){
    return  Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material (
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
           borderSide: const  BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(100)),
        child: InkWell
        (onTap: ()=> OnBtnTap(value),
          child: Center(child: Text(value,
          style:const TextStyle(fontWeight:FontWeight.bold,fontSize:24 ),))),
      ),
    );
  }
  
  //#########
  void OnBtnTap(String value){
    if(value==Btn.del){
      delete();
      return ;
    }
    if(value==Btn.clr){
      clearall();
      return ;
    }
    if(value==Btn.per){
      converToPercentage();
      return;
    }
    if(value==Btn.calculate){
      calculateAll();
      return ; 

    }

    
    appendValue(value);
    
  }
  //######
  //Calculate the equasion
  void calculateAll(){
     if(number1.isEmpty)return ;
     if(number2.isEmpty)return ;
     if(operand.isEmpty)return ;

     final double num1=double.parse(number1);
     final double num2=double.parse(number2);
     var result=0.0 ;
     switch (operand) {
       case Btn.add:
       result=num1+num2 ;
         break;
       case Btn.substract:
       result=num1-num2 ;
       break;
       case Btn.multiply:
       result=num1*num2 ;
       break ;
       case Btn.divide :
       result =num1/num2 ;
       break ;  
       default:
     }
     setState(() { 
       number1="$result"  ;
       //2.0
       if(number1.endsWith(".0")){
        number1=number1.substring(0,number1.length-2);
       }
       operand="";
       number2="";
       
     });

  }
   



  /////#####
  /// converts output to % 
  void converToPercentage(){
     if(number1.isNotEmpty&&operand.isNotEmpty&&operand.isNotEmpty){
      //calculate before conversion
      //TODO
      //fınal res=number1 operand number2 ;
      //number1=fınalres ; 
     }
     if (operand.isNotEmpty){
      return ;
     }
     final number=double.parse(number1) ;
     setState(() {
       number1="${(number/100)}";
       operand="";
       number2="";
     });

  }


  //######
  //delete one from the end
  void delete(){
    if(number2.isNotEmpty){
      //1234=>123   after substring
      number2=number2.substring(0,number2.length-1);
    }else if(operand.isNotEmpty){
      operand="";
    }else if(number1.isNotEmpty){ 
      number1=number1.substring(0,number1.length-1);
    }
    setState(() {
      
    });
  }

  //clear all
  void clearall(){
    if(number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty){
      number1="";
      number2="";
      operand="";
    }else if((number1.isNotEmpty && operand.isNotEmpty) ||(number1.isNotEmpty && operand.isEmpty)){
      number1="";
      operand="";
    }
    setState(() {
      
    });

  }





  //#######
  //append value to the end
  void appendValue(String value){
     //number1,operand,number2
    //234    +    2378 
    
    //if is operand and not "."
    if(value!=Btn.dot && int.tryParse(value)==null){ 
      //operand pressed
      if(operand.isNotEmpty && number2.isNotEmpty){
        //ToDo Calculate the equation before assigning new operator
      }
      operand=value; 
    }
    //assign value to number1 variable
    else if(number1.isEmpty || operand.isEmpty){
      //check if is value is "." || ex:number1=" 1.2"

      if(value==Btn.dot && number1.contains(Btn.dot)) return ;
      if(value==Btn.dot && (number1.contains(Btn.dot)|| number1.isEmpty)){
        // ex number1 =""||"0"
        value="0.";
      }
      number1+=value; 
    }
    //assign value to number2 variable
    else if(number2.isEmpty || operand.isNotEmpty){
      //check if is value is "." || ex:number2 =" 1.2"
      if(value==Btn.dot && number2.contains(Btn.dot)) return ;
      if(value==Btn.dot && (number2.contains(Btn.dot)|| number2.isEmpty)){
        //nummber2 =""||"0"
        value="0.";
      }
      number2+=value; 
    }

    setState(() {});
 
  }





  //#######

  Color getBtnColor(value){
    return  [Btn.clr,Btn.del].contains(value)?Colors.blueGrey:[Btn.per,
        Btn.multiply,Btn.add,Btn.substract,Btn.divide,Btn.calculate ].contains(value)? Colors.deepOrange:Colors.black87 ;

  }
}