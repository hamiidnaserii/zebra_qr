//input mobile-number
import 'package:flutter/material.dart';

Widget input(context,hint,icon,help,control,String error,isNumber) {

  InputDecoration inputDecoration = new InputDecoration();
  InputDecoration errorInput =InputDecoration(
      labelText: hint,
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      icon:icon,
      errorText:error,
      fillColor:Colors.redAccent,
      border: OutlineInputBorder(gapPadding: 5,borderRadius:BorderRadius.all(Radius.circular(100))),
      helperText: help
  );

  InputDecoration normalInput =InputDecoration(
      labelText: hint,
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      icon:icon,
      fillColor:Colors.redAccent,
      border: OutlineInputBorder(gapPadding: 5,borderRadius:BorderRadius.all(Radius.circular(100))),
      helperText: help
  );

  if(error.isEmpty){
    inputDecoration =normalInput;
  }else{
    inputDecoration =errorInput;
  }

  return Container(
    padding:EdgeInsets.symmetric(vertical:5,horizontal:20),
    child: TextField(
      keyboardType: (isNumber)?TextInputType.number:TextInputType.text,
      controller:control,
      textAlign: TextAlign.center,
      maxLines: 1,
      style: TextStyle(
          color: Colors.black, fontSize: 16),
      decoration:inputDecoration,
    ),
  );
}