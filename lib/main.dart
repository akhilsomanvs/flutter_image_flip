import 'package:flutter/material.dart';
import 'package:image_flip/controllers/meme_controller.dart';
import 'package:image_flip/views/homeScreen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:image_flip/arch_utils/utils/connection_status_singleton.dart';

void main() {
  // ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  // connectionStatus.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MemeController>(create: (context) => MemeController()),
      ],
      child: MaterialApp(
        title: 'Image Flip',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}