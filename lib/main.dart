import 'package:carinfo/app/app.dart';
import 'package:carinfo/app/di/di.dart';
import 'package:carinfo/core/network/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();
  await initDependencies();

  runApp(
    App(),
  );
}
