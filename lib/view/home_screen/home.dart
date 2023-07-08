import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/services/firestore_services.dart';
import 'package:diu_lab_management/view/home_screen/section.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedOption1 = 'Spring'; // Track the selected value for the first dropdown
  DateTime? selectedOption2; // Track the selected value for the second dropdown

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Image.asset(icApplogo).onTap(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }).box.margin(const EdgeInsets.only(left: 8)).make(),
      ),
      endDrawer: drawerWidget(context.screenWidth),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Fall 2023:'.text.color(highEmphasis).size(25).bold.make(),
            10.heightBox,
            StreamBuilder(
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
                        leading: Image.asset(icCourse, height: 40, color: whiteColor,),
                        title: '${data[index]['course_title']}'.text.white.size(20).make(),
                        trailing: Image.asset(icRight, height: 22, color: Colors.white30,),
                        onTap: () {
                          Get.to(()=> SectionScreen(data: data[index], semesterData: data[index].id,));
                        },
                      ).box.color(primary).roundedLg.padding(const EdgeInsets.all(8.0)).margin(const EdgeInsets.only(bottom: 8.0)).make();
                    }
                  
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
