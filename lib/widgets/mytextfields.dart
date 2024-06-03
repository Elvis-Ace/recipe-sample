import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe/basedata/formatter.dart';


class MyTextField extends StatefulWidget {
  final String hintstrin;
  bool secure;
  TextInputType textInputType;
  TextEditingController controller;
  bool border;
  Function onchange;

  MyTextField({required this.hintstrin,
    this.textInputType = TextInputType.name,
    required this.controller,
    required this.onchange,
    this.secure = false,
    this.border = true,
    Key? key})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool secure = false;

  checksecurity() {
    debugPrint(widget.border.toString());
    secure = widget.secure;
    setState(() {});
  }

  @override
  void initState() {
    checksecurity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      obscureText: secure,
      style: const TextStyle(color: Colors.black),
      textCapitalization: TextCapitalization.words,
      onChanged: (val){
        widget.onchange(val);
      },
      decoration: InputDecoration(
        hintText: widget.hintstrin,
        labelText: widget.hintstrin,
        hintStyle: GoogleFonts.inter(),
        border: widget.border ? const OutlineInputBorder() : InputBorder.none,
        enabledBorder: widget.border
            ? const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.black),
        )
            : null,
        suffixIcon: IconButton(
          onPressed: () {
            if (widget.secure) {
              if (secure) {
                secure = false;
              } else {
                secure = true;
              }

              setState(() {});
            } else {
              widget.controller.clear();
            }
          },
          icon: widget.secure
              ? const Icon(Icons.remove_red_eye)
              : const Icon(Icons.clear),


        ),
      ),
    );
  }
}

//icon TextFormField
class FormTextField extends StatefulWidget {
  final String hintstrin;
  bool secure;
  TextInputType textInputType;
  TextEditingController controller;
  IconData icon;

  FormTextField(this.hintstrin, this.textInputType, this.controller,
      this.secure, this.icon);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool secure = false;

  checksecurity() {
    secure = widget.secure;
    setState(() {});
  }

  @override
  void initState() {
    checksecurity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      obscureText: secure,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: widget.hintstrin,
          labelText: widget.hintstrin,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.blueAccent),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (widget.secure) {
                secure = false;
                setState(() {});
              } else {
                widget.controller.clear();
              }
            },
            icon: widget.secure
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.clear),
          ),
          prefixIcon: Icon(widget.icon)),
    );
  }
}

//formated
class MyFormatedTextField extends StatefulWidget {
  final String hintstrin;
  TextEditingController controller;

  MyFormatedTextField(
      {required this.hintstrin, required this.controller, Key? key})
      : super(key: key);

  @override
  State<MyFormatedTextField> createState() => _MyFormatedTextFieldState();
}

class _MyFormatedTextFieldState extends State<MyFormatedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: widget.controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: widget.hintstrin,
          labelText: widget.hintstrin,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.blueAccent),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              widget.controller.clear();
            },
            icon: const Icon(Icons.clear),
          )),
      onChanged: (val) {
        String data = MyFormatter.formatNumber(val);
        setState(() {
          widget.controller.text = data;
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length));
        });
      },
      onEditingComplete: () {
        debugPrint('Ace Here');
      },
    );
  }
}

class MyCustomTexField extends StatefulWidget {
  final String hintstrin, value;
  int id;
  Function? action;

  MyCustomTexField({
    required this.hintstrin,
    required this.value,
    required this.id,
    this.action,
    super.key,
  });

  @override
  State<MyCustomTexField> createState() => _MyCustomTexFieldState();
}

class _MyCustomTexFieldState extends State<MyCustomTexField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: widget.hintstrin,
          labelText: widget.hintstrin,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.blueAccent),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.clear),
          )),
      onChanged: (val) {
        if (val.isNotEmpty) {
          String data = MyFormatter.formatNumber(val);
          setState(() {
            controller.text = data;
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          });
          widget.action!(controller.text, widget.id);
        }
      },
      onEditingComplete: () {
        if (controller.text.isNotEmpty) {
          debugPrint(controller.text);
          widget.action!(controller.text, widget.id);
        }
      },
    );
  }
}

class FilterTextField extends StatefulWidget {
  final String hintstrin;
  TextEditingController controller;
  Function action;

  FilterTextField({required this.hintstrin,
    required this.controller,
    required this.action,
    super.key});

  @override
  State<FilterTextField> createState() => _FilterTextFieldState();
}

class _FilterTextFieldState extends State<FilterTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: widget.controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: widget.hintstrin,
          labelText: widget.hintstrin,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.blueAccent),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              widget.controller.clear();
            },
            icon: const Icon(Icons.clear),
          )),
      onChanged: (val) async {
        await widget.action();
        debugPrint(val);
      },
      onEditingComplete: () {
        debugPrint('Ace Here');
      },
    );
  }
}



class MyCalendarTextField extends StatefulWidget {
  final String hintstrin;
  TextInputType textInputType;
  TextEditingController controller;
  bool border;
  Function onchange;

  MyCalendarTextField({
    required this.hintstrin,
    this.textInputType = TextInputType.name,
    required this.controller,
    required this.onchange,
    this.border = true,super.key}
  );

  @override
  State<MyCalendarTextField> createState() => _MyCalendarTextFieldState();
}

class _MyCalendarTextFieldState extends State<MyCalendarTextField>  with RestorationMixin {
  @override
  String? get restorationId => 'main';

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );

  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {

    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        widget.controller.text ='${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      style: const TextStyle(color: Colors.black),
      textCapitalization: TextCapitalization.words,
      onChanged: (val){
        widget.onchange();
      },
      decoration: InputDecoration(
        hintText: widget.hintstrin,
        labelText: widget.hintstrin,
        hintStyle: GoogleFonts.inter(),
        border: widget.border ? const OutlineInputBorder() : InputBorder.none,
        enabledBorder: widget.border
            ? const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.black),
        )
            : null,
        suffixIcon: IconButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          icon:const Icon(Icons.calendar_month),


        ),
      ),
    );
  }

}

class MyDateTimePicker extends StatefulWidget {
  final String hintstrin;
  TextInputType textInputType;
  TextEditingController controller;
  bool border;
  Function onchange;
  MyDateTimePicker({required this.hintstrin,
  this.textInputType = TextInputType.name,
  required this.controller,
  required this.onchange,
  this.border = true,super.key});

  @override
  State<MyDateTimePicker> createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      style: const TextStyle(color: Colors.black),
      textCapitalization: TextCapitalization.words,
      onChanged: (val){
        widget.onchange();
      },
      decoration: InputDecoration(
        hintText: widget.hintstrin,
        labelText: widget.hintstrin,
        hintStyle: GoogleFonts.inter(),
        border: widget.border ? const OutlineInputBorder() : InputBorder.none,
        enabledBorder: widget.border
            ? const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.black),
        )
            : null,
        suffixIcon: IconButton(
          onPressed: () {
            DatePickerBdaya.showDateTimePicker(
              context,
              showTitleActions: true,
              minTime: DateTime.now(),
              maxTime: DateTime(2025, 6, 7, 05, 09),
              onChanged: (datet) {
                //date.text = datet;
                debugPrint(
                    'change ${widget.controller.text} in time zone ${datet.timeZoneOffset.inHours}');
              },
              onConfirm: (datet) {
                widget.controller.text = MyFormatter.mydateformat(datet);
                debugPrint('confirm ${widget.controller.text}');
                setState(() {

                });
              },
            );
          },
          icon:const Icon(Icons.calendar_month),


        ),
      ),
    );
  }
}
