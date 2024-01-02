import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqshrevision/src/ui/home/home_screen.dart';
import 'package:naqshrevision/src/ui/login/login_screen.dart';
import 'package:naqshrevision/src/utils/cache.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.init();
  await ThemePreferences.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String accessToken = CacheService.getToken();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Naqsh Revision',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: accessToken.isEmpty?const LoginScreen():const HomeScreen(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
        );
      },
    );
  }
}

