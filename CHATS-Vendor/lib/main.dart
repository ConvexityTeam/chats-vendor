import 'package:CHATS_Vendor/app_route.dart';
import 'package:CHATS_Vendor/locator.dart';
// import 'package:CHATS_Vendor/ui/screen/home.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
      ),
      onGenerateRoute: RoutePath.routePath,
      // home: HomeView(),
      initialRoute: 'splash',
    );
  }
}
