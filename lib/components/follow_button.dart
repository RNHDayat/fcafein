import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowButton extends StatefulWidget {
  final bool isFollowing;
  const FollowButton({super.key, required this.isFollowing});

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollowing = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFollowing = widget.isFollowing;
  }

  // void _toggleFollowing() {
  //   setState(() {
  //     _isFollowing = !_isFollowing;
  //   });
  // }

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
    return Container(
      // onPressed: _toggleFollowing,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: buttonColor,
        ),
        // side: BorderSide(color: buttonColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          buttonIcon,
          SizedBox(
            width: 5,
          ),
          Text(
            buttonLabel,
            style: GoogleFonts.poppins(
              color: buttonColor,
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
