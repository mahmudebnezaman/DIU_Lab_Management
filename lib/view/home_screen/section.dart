import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/services/firestore_services.dart';
import 'package:diu_lab_management/view/home_screen/section_details.dart';
import 'package:diu_lab_management/view/home_screen/home.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';

class SectionScreen extends StatefulWidget {

  final dynamic data;
  final dynamic semesterData;

  const SectionScreen({super.key, required this.data, required this.semesterData});

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.data['course_title']}', style: const TextStyle(fontWeight: FontWeight.bold)),
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
            'Section:'.text.color(highEmphasis).size(25).bold.make(),
            10.heightBox,
            StreamBuilder(
              stream: FireStoreServices.getSection(widget.data.id),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (!snapshot.hasData){
                  return Center(
                    child: loadingIndicator(),
                  );
                }else if (snapshot.data!.docs.isEmpty){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      'No section added yet!'.text.size(20).makeCentered()
                    ],
                  );
                }else{
                  var data = snapshot.data!.docs;
                  data.sort((a, b) => a['section_name'].compareTo(b['section_name']));
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: Image.asset(icSection, height: 40, color: whiteColor,),
                        title: '${data[index]['section_name']}'.text.white.size(20).make(),
                        trailing: Image.asset(icRight, height: 22, color: Colors.white30,),
                        onTap: () {
                          Get.to(()=> SectionDetailsScreen(data: data[index], parentData: widget.semesterData,));
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
