import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/translate_provider.dart';
import 'screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TranslateProvider>.value(
          value: TranslateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Translate',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue[600],
        ),
        home: HomePage(title: 'Google Translate'),
      ),
    );
  }
}
