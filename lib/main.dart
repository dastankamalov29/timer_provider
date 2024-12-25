import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app_provider/timer/provider/time_provider.dart';

import 'timer/screens/countdown_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      
      create: (context) => TimeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CountdownTimer(),
      ),
    );
  }
}