import 'package:flutter/material.dart';
import 'package:numbers/core/utils/service_locator.dart';
import 'package:numbers/features/numbers/presentation/pages/numbers_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize service locator
  await registerServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numbers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: NumbersPage(),
    );
  }
}
