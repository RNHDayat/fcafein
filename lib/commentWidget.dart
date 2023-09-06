import 'package:flutter/material.dart';

import 'model/database.dart';
import 'model/dbhelper.dart';

class CommentWidget extends StatefulWidget {
  final Map<String, dynamic> comment;

  CommentWidget({required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Widget _buildComment(Map<String, dynamic> comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        if (comment['repliedData'] != null)
          for (var reply in comment['repliedData'])
            CommentWidget(comment: reply),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildComment(widget.comment);
  }
}
