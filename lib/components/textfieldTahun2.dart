import 'package:flutter/material.dart';

class YearDropdownFormField extends StatefulWidget {
  YearDropdownFormField({
    Key? key,
    this.initialValue,
    this.firstYear = 1950,
    this.lastYear = 2023,
  }) : super(key: key);

  final int? initialValue;
  final int firstYear;
  final int lastYear;

  @override
  _YearDropdownFormFieldState createState() => _YearDropdownFormFieldState();
}

class _YearDropdownFormFieldState extends State<YearDropdownFormField> {
  late List<int> _years;
  int? _selectedYear;
  @override
  void initState() {
    super.initState();
    _years = List<int>.generate(
        widget.lastYear - widget.firstYear + 1, (i) => widget.firstYear + i);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: widget.initialValue,
      onChanged: (year) {
        setState(() {
          _selectedYear = year;
        });
      },
      items: _years
          .map<DropdownMenuItem<int>>(
            (year) => DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            ),
          )
          .toList(),
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
