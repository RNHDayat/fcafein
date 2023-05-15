import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({Key? key}) : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollowing = true;

  void _toggleFollowing() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String buttonLabel = _isFollowing ? 'Ikuti' : 'Mengikuti';
    final Color buttonColor = _isFollowing ? Colors.blue : Colors.grey;
    final Icon buttonIcon = _isFollowing
        ? Icon(
            Icons.account_circle,
            color: buttonColor,
          )
        : Icon(
            Icons.no_accounts,
            color: buttonColor,
          );
    return OutlinedButton.icon(
      onPressed: _toggleFollowing,
      style: TextButton.styleFrom(
        side: BorderSide(color: buttonColor),
        shape: RoundedRectangleBorder(
          side: const BorderSide(),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      icon: buttonIcon,
      label: Text(
        buttonLabel,
        style: GoogleFonts.poppins(
            color: buttonColor,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
