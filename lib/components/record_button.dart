import 'dart:async';

import 'package:flutter/material.dart';

class RecordButton extends StatefulWidget {
  RecordButton({
    this.leftWidget,
    this.rightWidget,
    this.onClick,
    @required this.isActive,
  });

  final bool isActive;
  final Widget leftWidget;
  final Widget rightWidget;
  final Function(bool) onClick;

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  Animation<double> _animation2;
  AnimationController _controller;
  AnimationController _controller2;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _controller2 =
            AnimationController(vsync: this, duration: Duration(seconds: 2))
              ..repeat();
        _animation2 =
            CurvedAnimation(parent: _controller2, curve: Curves.linear);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Widget _displaysButtonWave2() {
    if (widget.isActive && _animation2 != null) {
      return Center(
        child: ScaleTransition(
          scale: _animation2,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.red,
                style: BorderStyle.solid,
              ),
            ),
            height: 140,
            width: 140,
          ),
        ),
      );
    } else {
      return Container(
        height: 140,
        width: 140,
      );
    }
  }

  Widget _displaysButtonWave1() {
    if (widget.isActive && _animation != null) {
      return Center(
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.red,
                style: BorderStyle.solid,
              ),
            ),
            height: 140,
            width: 140,
          ),
        ),
      );
    } else {
      return Container(
        height: 140,
        width: 140,
      );
    }
  }

  Widget _displaysRecordingButton() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      child: ButtonTheme(
        minWidth: 70.0,
        height: 70.0,
        child: RaisedButton(
          onPressed: () {
            widget.onClick(widget.isActive);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          elevation: widget.isActive ? null: 0,
          color: widget.isActive ? Colors.red : Color(0xFFededed),
          child: Icon(
            Icons.mic,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _displaysButtonWave1(),
        _displaysButtonWave2(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            widget.leftWidget != null
                ? widget.leftWidget
                : Expanded(
                    child: Container(),
                  ),
            _displaysRecordingButton(),
            widget.rightWidget != null
                ? widget.rightWidget
                : Expanded(
                    child: Container(),
                  ),
          ],
        ),
      ],
    );
  }
}
