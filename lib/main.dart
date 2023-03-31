import 'package:CHATS_Vendor/app_module.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
// import 'package:CHATS_Vendor/ui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' as device;
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   setUpLocator();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//             // scaffoldBackgroundColor: Colors.white,
//             brightness: _brightness,
//           ),
//       onGenerateRoute: RoutePath.routePath,
//       // home: HomeView(),
//       initialRoute: 'splash',
//     );
//   }
// }

void main() async {
  // if (kDebugMode) HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // newSetUpLocator();
  // setUpLocator();

  ///* Define startup configuration for device when app launch

  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();

  await device.SystemChrome.setPreferredOrientations(
      [device.DeviceOrientation.portraitUp]);
  await device.SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [device.SystemUiOverlay.bottom]);
  device.SystemChrome.setSystemUIOverlayStyle(
      device.SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(ModularApp(module: AppModule(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  // this widget is the root of your application
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultBrightness: Brightness.light,
      builder: (context, _brightness) {
        return ScreenUtilInit(
            designSize: Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, widget) {
              return MaterialApp.router(
                builder: (context, child) {
                  final mediaQueryData = MediaQuery.of(context);
                  final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
                  return MediaQuery(
                    child: const String.fromEnvironment('BUILD_ENV') ==
                            'development'
                        ? CheckedModeBanner(child: child!)
                        : child!,
                    data:
                        MediaQuery.of(context).copyWith(textScaleFactor: scale),
                  );
                },
                debugShowCheckedModeBanner:
                    const String.fromEnvironment('BUILD_ENV') == 'development'
                        ? true
                        : false,
                // onGenerateRoute: RoutePath.routePath,
                // initialRoute: 'splash',
                routeInformationParser: Modular.routeInformationParser,
                routerDelegate: Modular.routerDelegate,
                title: 'CHATS Vendor',
                theme: ThemeData(
                  brightness: _brightness,
                  // scaffoldBackgroundColor:
                  //     ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                  //         ? Colors.white
                  //         : primaryColorDarkMode,
                ),

                // home: MajorSplashScreen(),
              );
            });
      },
    );
  }
}
