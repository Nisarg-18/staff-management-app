import 'package:flutter/material.dart';
import 'package:staff_app/screens/dashboard.dart';
import 'package:staff_app/services/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDb.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
