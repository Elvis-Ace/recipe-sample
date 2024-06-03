import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe/basedata/basedata.dart';

class MyTextView extends StatefulWidget {
  int maxlines;
  double fontsize;
  Color color;
  FontWeight fontWeight;
  String data;
  MyTextView({
    super.key,
    required this.data,
    this.maxlines = 1,
    this.color = Colors.black,
    this.fontsize = 14,
    this.fontWeight = FontWeight.normal,
  });
  @override
  State<MyTextView> createState() => _MyTextViewState();
}

class _MyTextViewState extends State<MyTextView> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.data,
      maxLines: widget.maxlines,
      style: GoogleFonts.inter(
        color: widget.color,
        fontWeight: widget.fontWeight,
        fontSize: widget.fontsize,
      ),
    );
  }
}

//richtext
class MyFormatedText extends StatefulWidget {
  String original, sub, fontfamily;
  double fontsize;
  Color colors;
  FontWeight fontWeight;
  MyFormatedText(this.original, this.sub, this.fontfamily, this.colors,
      this.fontWeight, this.fontsize,
      {Key? key})
      : super(key: key);

  @override
  State<MyFormatedText> createState() => _MyFormatedTextState();
}

class _MyFormatedTextState extends State<MyFormatedText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: widget.original,
            style: TextStyle(
                fontWeight: widget.fontWeight,
                fontFamily: widget.fontfamily,
                color: Basedata.basecolor,
                fontSize: widget.fontsize + 15),
            children: <TextSpan>[
          TextSpan(
            text: widget.sub,
            style: TextStyle(
                fontWeight: widget.fontWeight,
                fontFamily: widget.fontfamily,
                color: widget.colors,
                fontSize: widget.fontsize),
          )
        ]));
  }
}
