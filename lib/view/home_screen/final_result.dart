import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/controller/semester_controller.dart';
import 'package:diu_lab_management/services/firestore_services.dart';
import 'package:diu_lab_management/view/home_screen/edit_result_screen.dart';
import 'package:diu_lab_management/widgets-common/appbar_widget.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';
import 'package:diu_lab_management/widgets-common/my_button.dart';

class FinalResultScreen extends StatefulWidget {
  final dynamic data;
  final dynamic courseID;

  const FinalResultScreen({Key? key, required this.data, required this.courseID}) : super(key: key);

  @override
  State<FinalResultScreen> createState() => _FinalResultScreenState();
}

class _FinalResultScreenState extends State<FinalResultScreen> {
  var controller = Get.put(SemesterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context, title: '${widget.data['id']}'
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
          child: StreamBuilder<dynamic>(
            stream: FireStoreServices.getStudentDetails(widget.courseID, widget.data.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
            
                String calculateFinalResult() {
                  int weekOneLP = int.parse(data['week_one_lp']);
                  int weekTwoLP = int.parse(data['week_two_lp']);
                  int weekThreeLP = int.parse(data['week_three_lp']);
                  int weekFourLP = int.parse(data['week_four_lp']);
                  int weekFiveLP = int.parse(data['week_five_lp']);
                  int assignment = int.parse(data['assignment']);
                  int project = int.parse(data['project']);
                  int labFinal = int.parse(data['lab_final']);
      
                  weekOneLP != 0 ? weekOneLP+=2 : weekOneLP+=0;
                  weekTwoLP != 0 ? weekTwoLP+=2 : weekTwoLP+=0;
                  weekThreeLP != 0 ? weekThreeLP+=2 : weekThreeLP+=0;
                  weekFourLP != 0 ? weekFourLP+=2 : weekFourLP+=0;
                  weekFiveLP != 0 ? weekFiveLP+=2 : weekFiveLP+=0;
      
                  var result = weekOneLP + weekTwoLP + weekThreeLP + weekFourLP + weekFiveLP+ assignment + project + labFinal;
      
                  if (result >= 80){
                    return 'A+';
                  }else if (result >= 75){
                    return 'A';
                  }else if (result >= 70){
                    return 'A-';
                  }else if (result >= 65){
                    return 'B+';
                  }else if (result >= 60){
                    return 'B';
                  }else if (result >= 55){
                    return 'B-';
                  }else if (result >= 50){
                    return 'C+';
                  }else if (result >= 45){
                    return 'C';
                  }else if (result >= 40){
                    return 'D';
                  }else{
                    return 'F';
                  }
                }
      
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Center(
                     child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(icResult, height: 30, color: highEmphasis,), 5.widthBox,
                              'Final Result: '.text.bold.color(highEmphasis).size(30).make(),
                            ],
                          ),
                          10.heightBox,
                          calculateFinalResult().text.bold.size(100).color(calculateFinalResult() == 'F' ? Colors.red : Colors.green).make().box.roundedFull.padding(const EdgeInsets.all(20.0)).border(color: calculateFinalResult() == 'F' ? Colors.red : Colors.green, width: 4).make(),
                        ],
                      ),
                   ),
                    10.heightBox,
                    Center(
                      child: myButton(
                        buttonSize: 20.0,
                        color: primary,
                        textColor: whiteColor,
                        title: 'Evaluate Result',
                        onPress: (){
                          Get.to(()=> EditResultScreen(data: data, courseID: widget.courseID,));
                        }
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            }
          ),
        ),
      ),
    );


  }
}
