import 'package:diu_lab_management/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'const/consts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DIU Lab Assistant",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: highEmphasis,
            fontFamily: bold,
            fontSize: 25,
          ),
          backgroundColor: whiteColor,
          elevation: 1,
          iconTheme: IconThemeData(
            color: darkFontGrey,
          )
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}

