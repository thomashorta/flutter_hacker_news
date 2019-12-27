import 'package:flutter/material.dart';

class LoadingListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleSize = theme.textTheme.subhead.fontSize;
    final subTitleSize = theme.textTheme.body1.fontSize;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              height: titleSize,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(
              height: subTitleSize,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
