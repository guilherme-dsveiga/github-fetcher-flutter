import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app.dart';

void main() => {
  WidgetsFlutterBinding.ensureInitialized(),
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
  runApp(App())
};
