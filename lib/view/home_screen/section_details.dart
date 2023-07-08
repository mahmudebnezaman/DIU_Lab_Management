import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/controller/semester_controller.dart';
import 'package:diu_lab_management/services/firestore_services.dart';
import 'package:diu_lab_management/view/home_screen/home.dart';
import 'package:diu_lab_management/view/home_screen/student_details.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';

class SectionDetailsScreen extends StatefulWidget {
  final dynamic data;
  final dynamic parentData;

  const SectionDetailsScreen({Key? key, required this.data, required this.parentData}) : super(key: key);

  @override
  State<SectionDetailsScreen> createState() => _SectionDetailsScreenState();
}

class _SectionDetailsScreenState extends State<SectionDetailsScreen> {
  var controller = Get.put(SemesterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Section: ${widget.data['section_name']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
            'Students:'.text.color(highEmphasis).size(25).bold.make(),
            10.heightBox,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FireStoreServices.getStudents(widget.parentData, widget.data.id),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var student = snapshot.data!.docs[index];
                      return ListTile(
                        leading: Image.asset(icStudent, height: 40, color: whiteColor,),
                        title: Text('${student['id']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor)),
                        onTap: () {
                          Get.to(()=> StudentDetailsScreen(data: student, semesteID: widget.parentData, courseID: widget.data.id,));
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
    );
  }
}
