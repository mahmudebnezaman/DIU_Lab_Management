import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/services/firestore_services.dart';
import 'package:diu_lab_management/view/home_screen/class_details.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back,color: primary,size: 30,).onTap(() {Get.back();}),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.home_filled, color: primary,size: 30),
                            'Home'.text.semiBold.color(primary).make(),
                          ],
                        ).box.color(Colors.blue.shade50).rounded.padding(const EdgeInsets.all(8.0)).make().onTap(() {Get.off(()=> const HomeScreen());}),
                        10.widthBox,
                        Row(
                          children: [
                            const Icon(Icons.account_circle, color: primary,size: 30),
                            'Profile'.text.semiBold.color(primary).make(),
                          ],
                        ).box.color(Colors.blue.shade50).rounded.padding(const EdgeInsets.all(8.0)).make().onTap(() {Get.to(()=> const ProfileScreen());})
                      ],
                    )
                  ],
                ),
                10.heightBox,
                'Your Classes'.text.semiBold.size(20).color(highEmphasis).make(),
                10.heightBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                      stream: FireStoreServices.getCourse(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if (!snapshot.hasData){
                          return Center(
                            child: loadingIndicator(),
                          );
                        }else if (snapshot.data!.docs.isEmpty){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              'No course added yet!'.text.size(20).makeCentered()
                            ],
                          );
                        }else{
                          var data = snapshot.data!.docs;
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index){
                              return ListTile(
                                leading: Image.asset(icCourse),
                                title: '${data[index]['course_title']}'.text.color(highEmphasis).size(18).make(),
                                subtitle: '${data[index]['section']}'.text.white.size(14).make(),
                                trailing: Image.asset(icRight, height: 14, color: Colors.white30,),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => ClassDetailsScreen(data: data[index])),
                                  );
                                },
                              ).box.color(primary).roundedLg.padding(const EdgeInsets.all(8.0)).margin(const EdgeInsets.only(bottom: 8.0)).make();
                            }
                          );
                        }
                      },
                    ),
                  ),
                ),
                // const Spacer(),
                5.heightBox,
                myButton(
                  buttonSize: 20.0,
                  color: whiteColor,
                  textColor: primary,
                  title: 'Log Out',
                  onPress:  () async {
                    await Get.put(AuthController()).signoutMethod(context);
                    Get.offAll( ()=> const LoginScreen());
                  },
                ).box.border(color: primary, width: 2).roundedLg.width(width).make(),
                5.heightBox
              ],
            ),
          ),
        ),
      );
}