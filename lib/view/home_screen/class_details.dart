import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/controller/semester_controller.dart';
import 'package:diu_lab_management/services/firestore_services.dart';
import 'package:diu_lab_management/view/home_screen/home.dart';
// import 'package:diu_lab_management/view/home_screen/home.dart';
import 'package:diu_lab_management/view/home_screen/final_result.dart';
import 'package:diu_lab_management/widgets-common/appbar_widget.dart';
import 'package:diu_lab_management/widgets-common/custom_textfeild.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';
import 'package:diu_lab_management/widgets-common/my_button.dart';

class ClassDetailsScreen extends StatefulWidget {
  static const String routeName = '/section';
  final dynamic data;

  const ClassDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  var controller = Get.put(SemesterController());
  String srchtext = '';
    @override
  void initState() {
    super.initState();
    controller.studentIdController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(()=>const HomeScreen()); // Navigate back to the previous screen (HomeScreen)
        return true;
      },
      child: Scaffold(
        appBar:appBarWidget(
          context: context,
          title: '${widget.data['course_title']} ${widget.data['section']}'
        ),
        endDrawer: drawerWidget(context.screenWidth),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                'You have a class on:'.text.color(highEmphasis).size(18).semiBold.make(),
                5.heightBox,
                '${widget.data['routine']}'.text.color(Colors.green).size(18).semiBold.make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  'Room No: '.text.color(highEmphasis).size(18).semiBold.make(),
                  '${widget.data['room']}'.text.color(Colors.green).size(18).semiBold.make(),
                  ],
                ),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  'Total Registered Student: '.text.color(highEmphasis).size(18).semiBold.make(),
                  // '${widget.data['room']}'.text.color(Colors.green).size(18).semiBold.make(),
                  StreamBuilder(
                    stream: FireStoreServices.getStudents(widget.data.id),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      var student = snapshot.data?.docs;
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
        
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: loadingIndicator());
                      }
        
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('0', style: TextStyle(fontSize: 20)));
                      }
                      return student!.length.text.size(18).color(Colors.green).bold.make();
                    }
                  )
                  ],
                ),
                10.heightBox,
                // customTextFeild(title: 'Add Student', hint: 'ID', controller: controller.studentIdController),
                // Center(
                //   child: myButton(
                //     title: 'confirm',
                //     buttonSize: 12.0,
                //     color: Colors.blue,
                //     textColor: whiteColor,
                //     onPress: (){
                //       controller.registerNewStudent(widget.data.id);
                //     }
                //   ),
                // ),
                'Provide student ID to evaluate'.text.color(highEmphasis).size(20).bold.makeCentered(),
                10.heightBox,
                customTextFeild(title: 'Student ID', hint: 'xxx-xx-xxxxx', controller: controller.studentIdController, prefixIcon:const Icon(Icons.people)),
                Center(
                  child: myButton(
                    title: 'Search',
                    buttonSize: 20.0,
                    color: primary,
                    textColor: whiteColor,
                    onPress: (){
                      setState(() {
                        srchtext = controller.studentIdController.text;
                      });
                    }
                  ),
                ),
                // 'Students:'.text.color(highEmphasis).size(25).bold.makeCentered(),
                10.heightBox,
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FireStoreServices.getStudents(widget.data.id),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      var student = snapshot.data?.docs;
                      var filtered = student?.where((element) => element['id']
                            .toString()
                            .toLowerCase()
                            .contains(controller.studentIdController.text != '' ? srchtext : 'abcde'))
                        .toList();
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
        
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: loadingIndicator());
                      }
        
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No students registered yet!', style: TextStyle(fontSize: 20)));
                      }
        
                      return ListView.builder(
                        itemCount: filtered!.length,
                        itemBuilder: (BuildContext context, int index) {
                          
                          return ListTile(
                            leading: Image.asset(icStudent, height: 40, color: whiteColor,),
                            title: Text('${filtered[index]['id']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor)),
                            onTap: () {
                              Get.to(()=> FinalResultScreen(data: filtered[index], courseID: widget.data.id,));
                            },
                            trailing: Image.asset(icRight, height: 22, color: Colors.white30,),
                          ).box.roundedSM.color(primary).margin(const EdgeInsets.only(bottom: 4)).make();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
