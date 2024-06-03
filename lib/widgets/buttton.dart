import 'package:flutter/material.dart';
import 'package:recipe/basedata/basedata.dart';

import 'mytext.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  MyButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        // ignore: sort_child_properties_last
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: MyTextView(data: title,fontsize: 16,color: Colors.white,),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Basedata.basecolor,
        ),
      ),
    );
  }
}


class MyCustomButton extends StatefulWidget {
  String text;
  Color color,textcolor;
  final VoidCallback action;
  MyCustomButton({required this.text,this.color = Colors.green,this.textcolor = Colors.white,required this.action,super.key});

  @override
  State<MyCustomButton> createState() => _MyCustomButtonState();
}

class _MyCustomButtonState extends State<MyCustomButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: widget.action,
        style: OutlinedButton.styleFrom(
          foregroundColor: widget.textcolor,
          backgroundColor: Basedata.basecolor,
          padding:const EdgeInsets.only(left: 10,right: 10),
          elevation: 0,
          side: BorderSide(
            color: widget.color
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          )
        ),
        child: MyTextView(data:widget.text,color:widget.textcolor,fontsize:13,fontWeight:FontWeight.bold)
    );
  }
}


class MyIconButton extends StatefulWidget {
  IconData icon;
  String tooltip;
  Color color;
  Function function;
  MyIconButton({required this.icon,required this.tooltip,this.color = Colors.black,required this.function,super.key});

  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(widget.icon,color: Colors.white,),
      style: OutlinedButton.styleFrom(
          backgroundColor: Basedata.basecolor,
          padding:const EdgeInsets.only(left: 10,right: 10),
          elevation: 0,
          side: BorderSide(
              color: widget.color
          ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        )
      ),
      onPressed: () {
        widget.function();
      }, label: MyTextView(data: widget.tooltip,color: Colors.white,),
    );
  }
}
