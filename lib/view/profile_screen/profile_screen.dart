// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/services/firestore_services.dart';
import 'package:diu_lab_management/view/auth_screen/login_screen.dart';
import 'package:diu_lab_management/view/profile_screen/change_password.dart';
import 'package:diu_lab_management/view/profile_screen/edit_profile.dart';

import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/widgets-common/appbar_widget.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';

import 'package:diu_lab_management/widgets-common/my_button.dart';

import 'package:diu_lab_management/controller/auth_controller.dart';
import 'package:diu_lab_management/controller/profile_controller.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context: context, title: 'Profile'),
      endDrawer: drawerWidget(context.screenWidth),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primary,
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: StreamBuilder(
          stream: FireStoreServices.getUser(auth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
                return Center(child: loadingIndicator());
              } else {
                var data = snapshot.data!.docs[0];
                return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        data['imageUrl'] == '' ? const Icon(Icons.account_circle, size: 200, color: primary,).box.roundedFull.white.shadow3xl.make() 
                        : Image.network(data['imageUrl'],fit: BoxFit.cover,height: 200,width: 200).box.clip(Clip.antiAlias).roundedFull.white.shadow3xl.make().box.height(200).width(200).make(),
                        10.heightBox,
                        "${data['name']}".text.size(30).bold.color(highEmphasis).make(),
                        "${data['email']}".text.size(25).color(fontGrey).make(),
                      ],
                    ),
                  ),
                  10.heightBox,
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(icEdit, height: 50,color: highEmphasis,),
                          5.heightBox,
                          "Edit".text.color(highEmphasis).size(18).bold.make(),
                          "Profile".text.color(highEmphasis).size(18).bold.make(),
                        ],
                      ).onTap(() {Get.to(()=> EditProfileInfo(data: data,));}),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(icPassword, height: 50,color: highEmphasis,),
                          5.heightBox,
                          "Change".text.color(highEmphasis).size(18).bold.make(),
                          "Password".text.color(highEmphasis).size(18).bold.make(),
                        ],
                      ).onTap(() {Get.to(()=> ChangePassword(data: data,));}),
                    ],
                  ),
                  const Spacer(),
                  myButton(
                    buttonSize: 20.0,
                    textColor: primary,
                    color: whiteColor,
                    onPress: () async {
                      await Get.put(AuthController()).signoutMethod(context);
                      Get.offAll( ()=> const LoginScreen());
                      },
                    title: 'Log Out'
                  ).box.border(color: primary, width: 2).roundedLg.width(context.screenWidth).make()
                ]),
            );
            }
      
          },
        ),
      ),
    );
  }
}
