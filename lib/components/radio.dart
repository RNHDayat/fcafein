import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  // final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const MyRadioOption({
    required this.value,
    required this.groupValue,
    // required this.label,
    required this.text,
    required this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: isSelected ? Colors.transparent : Colors.grey,
              ),
            ),
            color: isSelected ? Colors.blue : Colors.white,
          ),
        ),
        Container(
          width: 9,
          height: 9,
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: const TextStyle(color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () => onChanged(value),
        // splashColor: Colors.teal.withOpacity(0.5),
        child: Container(
          // padding: EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(),
              const SizedBox(width: 10),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }
}
