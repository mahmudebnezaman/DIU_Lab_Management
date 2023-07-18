import 'package:diu_lab_management/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/controller/auth_controller.dart';
import 'package:diu_lab_management/view/auth_screen/login_screen.dart';
import 'package:diu_lab_management/view/home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

var authcontroller = Get.put(AuthController());

changeScreen(){
    Future.delayed(const Duration(seconds: 2),(){
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted){
          Get.offAll (()=>const LoginScreen());
        } else  {
          Get.offAll(()=>const HomeScreen());
        }
      });
    });
  }

  @override
  void initState(){
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 241, 174, 251),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icApplogo).box.size(220, 220).make(),
            ],
          ),
        ),
      ),
    );
  }
}