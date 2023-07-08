import 'package:diu_lab_management/const/images.dart';
import 'package:path/path.dart';
import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/controller/auth_controller.dart';
import 'package:diu_lab_management/view/auth_screen/login_screen.dart';
import 'package:diu_lab_management/view/home_screen/home.dart';
import 'package:diu_lab_management/view/profile_screen/profile_screen.dart';
import 'package:diu_lab_management/widgets-common/my_button.dart';

Widget drawerWidget(width){
  return Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft, child: const Icon(Icons.arrow_back,).onTap(() {Get.back();})),
                10.heightBox,
                Row(
                  children: [
                    Image.asset(icDashboard,height: 20,),
                    20.widthBox,
                    'Dashboard'.text.center.semiBold.size(20).make()
                  ],
                ).box.padding(const EdgeInsets.symmetric(vertical: 20, horizontal: 30)).color(Colors.purpleAccent).width(width).roundedLg.shadow.make().onTap(() {Get.to(()=> const HomeScreen());}),
                10.heightBox,
                Row(
                  children: [
                    Image.asset(icUser,height: 20,),
                    20.widthBox,
                    'Profile'.text.center.semiBold.size(20).make()
                  ],
                ).box.padding(const EdgeInsets.symmetric(vertical: 20, horizontal: 30)).color(Colors.greenAccent).width(width).roundedLg.shadow.make().onTap(() {Get.to(()=> const ProfileScreen());}),
                const Spacer(),
                myButton(
                  buttonSize: 20.0,
                  color: whiteColor,
                  textColor: primary,
                  title: 'Sign Out',
                  onPress:  () async {
                    await Get.put(AuthController()).signoutMethod(context);
                    Get.offAll( ()=> const LoginScreen());
                  },
                ).box.border(color: primary, width: 2).roundedLg.width(width).make(),
                20.heightBox
              ],
            ),
          ),
        ),
      );
}