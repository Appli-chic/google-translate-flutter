import 'package:flutter/material.dart';
import 'package:google_translate/components/clips/discussion_right_clip.dart';

import 'clips/discussion_left_clip.dart';

class LanguageButtonDirection {
  const LanguageButtonDirection._(this.index);

  final int index;

  static const LanguageButtonDirection left = LanguageButtonDirection._(0);

  static const LanguageButtonDirection right = LanguageButtonDirection._(1);
}

class LanguageButton extends StatefulWidget {
  LanguageButton({
    @required this.language,
    @required this.direction,
    @required this.isSelected,
    @required this.onTap,
  });

  final String language;
  final LanguageButtonDirection direction;
  final bool isSelected;
  final Function onTap;

  @override
  _LanguageButtonState createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  CustomClipper<Path> _displaysDirection() {
    if (widget.direction == LanguageButtonDirection.left) {
      return DiscussionLeftClip();
    } else if (widget.direction == LanguageButtonDirection.right) {
      return DiscussionRightClip();
    } else {
      return DiscussionLeftClip();
    }
  }

  BorderRadiusGeometry _displaysRoundedCorners() {
    const leftRoundedCorners = BorderRadius.only(
      bottomLeft: Radius.circular(8),
      topLeft: Radius.circular(8),
    );

    if (widget.direction == LanguageButtonDirection.left) {
      return leftRoundedCorners;
    } else if (widget.direction == LanguageButtonDirection.right) {
      return BorderRadius.only(
        bottomRight: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    } else {
      return leftRoundedCorners;
    }
  }

  EdgeInsetsGeometry _addMargins() {
    const leftMargin = EdgeInsets.only(left: 4, bottom: 5);

    if (widget.direction == LanguageButtonDirection.left) {
      return leftMargin;
    } else if (widget.direction == LanguageButtonDirection.right) {
      return EdgeInsets.only(right: 4, bottom: 5);
    } else {
      return leftMargin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipPath(
        clipper: _displaysDirection(),
        child: Container(
          height: 60,
          margin: _addMargins(),
          decoration: BoxDecoration(
            color: widget.isSelected ? Colors.red : Color(0xFFededed),
            borderRadius: _displaysRoundedCorners(),
          ),
          child: Center(
            child: Text(
              widget.language,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
