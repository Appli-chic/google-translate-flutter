import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_translate/components/clips/discussion_left_clip.dart';
import 'package:google_translate/components/clips/discussion_right_clip.dart';
import 'package:google_translate/models/language.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ConversationPage extends StatefulWidget {
  ConversationPage({
    @required this.firstLanguage,
    @required this.secondLanguage,
  });

  final Language firstLanguage;
  final Language secondLanguage;

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage>
    with TickerProviderStateMixin {
  var _speech = SpeechToText();
  Timer _timer;
  String _lastWords = "";
  Animation<double> _animation;
  Animation<double> _animation2;
  AnimationController _controller;
  AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _initSpeechToText();

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
    super.dispose();

    _timer.cancel();
    _controller.dispose();
    _controller2.dispose();
    _speech.cancel();
  }

  _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (t.tick == 3) {
//        t.cancel();
//        _speech.stop();
//        Navigator.pop(context, _lastWords);
      }
    });
  }

  Future<void> _initSpeechToText() async {
    bool available = await _speech.initialize(
        onStatus: _statusListener, onError: _errorListener);

    if (available) {
      _startTimer();
      _speech.listen(
        onResult: _resultListener,
        localeId: widget.firstLanguage.code,
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  void _resultListener(SpeechRecognitionResult result) {
    if (!result.finalResult && _speech.lastStatus != "notListening") {
      _startTimer();
    }

    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void _errorListener(SpeechRecognitionError error) {
    print("${error.errorMsg} - ${error.permanent}");
  }

  void _statusListener(String status) {
    print("$status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Text(
                "Talk now...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Text(
                "Talk now...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: SizedOverflowBox(
              size: Size.fromHeight(70),
              child: Stack(
                children: <Widget>[
                  Center(
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
                  ),
                  _animation2 != null
                      ? Center(
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
                        )
                      : Container(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: ClipPath(
                          clipper: DiscussionLeftClip(),
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.only(left: 4, bottom: 5),
                            decoration: BoxDecoration(
                              color: Color(0xFFededed),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8),
                              ),
                              border: Border.all(color: Color(0xFFdadada)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: ButtonTheme(
                          minWidth: 70.0,
                          height: 70.0,
                          child: RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            color: Colors.red,
                            child: Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ClipPath(
                          clipper: DiscussionRightClip(),
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.only(right: 4, bottom: 5),
                            decoration: BoxDecoration(
                              color: Color(0xFFededed),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              border: Border.all(color: Color(0xFFdadada)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
