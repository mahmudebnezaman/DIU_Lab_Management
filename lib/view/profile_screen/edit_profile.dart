// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/controller/profile_controller.dart';
import 'package:diu_lab_management/widgets-common/custom_textfeild.dart';
import 'package:diu_lab_management/widgets-common/custom_passwordfeild.dart';
import 'package:diu_lab_management/widgets-common/my_button.dart';

class EditProfileInfo extends StatefulWidget {

  final dynamic data;
  const EditProfileInfo({super.key, this.data});

  @override
  State<EditProfileInfo> createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {


  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.data['name'];
    super.initState();
  }
  

  bool isPass = true;

  void togglePasswordView() {
    setState(() {
      isPass = !isPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    var nameIcon = const Icon(Icons.account_circle_outlined, size: 25,);

    return WillPopScope(
      onWillPop: () async {
        controller.reset();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              ()=> Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                      children: [
                        widget.data['imageUrl'] == '' && controller.profileImagePath.isEmpty? const Icon(Icons.account_circle, size: 200, color: primary,).box.clip(Clip.antiAlias).roundedFull.white.shadow3xl.make()
                        : widget.data['imageUrl'] != '' && controller.profileImagePath.isEmpty? Image.network(widget.data['imageUrl'],fit: BoxFit.cover,height: 200,width: 200).box.clip(Clip.antiAlias).roundedFull.border(color: whiteColor, width: 2).white.shadow3xl.make()
                        : Image.file(File(controller.profileImagePath.value), width: 200, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedFull.border(color: whiteColor, width: 2).white.shadow3xl.make(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(icPencil,fit: BoxFit.fill,color: highEmphasis,height: 30,).box.roundedFull.white.padding(const EdgeInsets.all(4)).shadowSm.make().onTap(() {
                      controller.changeImage(context);})),
            
                      ],
                    ).box.height(200).width(200).make(),
                  20.heightBox,
                  'Change your profile name'.text.color(highEmphasis).size(20).bold.make(),
                  10.heightBox,
                  customTextFeild(
                    controller: controller.nameController,
                    hint: 'Enter your name',
                    title: 'Name',
                    prefixIcon: nameIcon,
                  ),
                  10.heightBox,
                  customPasswordFeild(hint: 'Enter you password', title: 'Password', obsText: isPass, suffixIcon: InkWell(
                      onTap: togglePasswordView,
                      child: Icon(
                        isPass 
                          ? Icons.visibility 
                          : Icons.visibility_off,
                      )), controller: controller.passController),
                  
                  const Spacer(),
                  controller.isloading.value ? loadingIndicator() : SizedBox(
                    width: context.screenWidth-40,
                    child: myButton(
                      color: primary,
                      buttonSize: 20.0,
                      onPress: ()async{
            
                        controller.isloading(true);
            
                        //if image is not selected
                        if(controller.profileImagePath.value.isNotEmpty){
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImageLink = widget.data['imageUrl'];
                        }
            
                        //if old password matches database
                        if(widget.data['password'] == controller.passController.text){
                          await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          );
                          VxToast.show(context, msg: 'Updated');
                        } else{
                          VxToast.show(context, msg: 'Password doesnot matched');
                          controller.isloading(false);
                        }
                      },
                      textColor: whiteColor,
                      title: 'Save',
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}