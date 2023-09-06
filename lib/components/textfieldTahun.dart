//
import 'package:flutter/material.dart';

class YearPickerTextField extends StatefulWidget {
  const YearPickerTextField({Key? key}) : super(key: key);

  @override
  _YearPickerTextFieldState createState() => _YearPickerTextFieldState();
}

class _YearPickerTextFieldState extends State<YearPickerTextField> {
  TextEditingController _textEditingController = TextEditingController();

  Future<void> _select(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blue, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _textEditingController.text = picked.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _textEditingController,
      onTap: () => _select(context),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: '',
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      ),
    );
  }
}
