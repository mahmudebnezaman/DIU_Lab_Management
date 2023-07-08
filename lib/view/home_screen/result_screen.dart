import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/controller/semester_controller.dart';
import 'package:diu_lab_management/view/home_screen/home.dart';
import 'package:diu_lab_management/widgets-common/custom_textfeild.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';
import 'package:diu_lab_management/widgets-common/my_button.dart';

class ResultScreen extends StatefulWidget {
  final dynamic data;
  final dynamic semesteID;
  final dynamic courseID;

  const ResultScreen({Key? key, required this.data, required this.semesteID, required this.courseID}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var controller = Get.put(SemesterController());

  @override
  void initState() {
    super.initState();
    controller.week1LabController.text = widget.data['week_one_lp'];
    controller.week2LabController.text = widget.data['week_two_lp'];
    controller.week3LabController.text = widget.data['week_three_lp'];
    controller.week4LabController.text = widget.data['week_four_lp'];
    controller.week5LabController.text = widget.data['week_five_lp'];
    controller.projectController.text = widget.data['project'];
    controller.assignmentController.text = widget.data['assignment'];
    controller.labFinalController.text = widget.data['lab_final'];
  }

  @override
  Widget build(BuildContext context) {

    void validator(){
      if (int.parse(controller.week1LabController.text) > 5 || int.parse(controller.week2LabController.text) > 5 || int.parse(controller.week3LabController.text) > 5 || int.parse(controller.week4LabController.text) > 5 || int.parse(controller.week5LabController.text) > 5){
        VxToast.show(context, msg: 'max Lab Performance mark is 5');
      }else if(int.parse(controller.assignmentController.text) > 10 ){
        VxToast.show(context, msg: 'max Assignment mark is 10');
      }else if(int.parse(controller.projectController.text) > 25 ){
        VxToast.show(context, msg: 'max Project mark is 25');
      }else if(int.parse(controller.labFinalController.text) > 30 ){
        VxToast.show(context, msg: 'max Lab Final mark is 30');
      }else{
        controller.editStudentResult(widget.semesteID, widget.courseID, widget.data.id);
        VxToast.show(context, msg: 'Result Updated');
        Get.back();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.data['id']}',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              'Evaluate Result'.text.color(Colors.green).semiBold.size(20).make(),
              10.heightBox,
              const Divider(),
              customTextFeild(title: 'Week1 Lab Perfomance: ', hint: 'out of 5', keytype: TextInputType.number, prefixIcon: const Icon(Icons.task), controller: controller.week1LabController),
              'out of 5'.text.color(fontGrey).make(),
              const Divider(),
              5.heightBox,
              customTextFeild(title: 'Week2 Lab Perfomance: ', hint: 'out of 5', keytype: TextInputType.number, prefixIcon: const Icon(Icons.task), controller: controller.week2LabController),
              'out of 5'.text.color(fontGrey).make(),
              5.heightBox,
              customTextFeild(title: 'Week3 Lab Perfomance: ', hint: 'out of 5', keytype: TextInputType.number, prefixIcon: const Icon(Icons.task), controller: controller.week3LabController),
              'out of 5'.text.color(fontGrey).make(),
              const Divider(),
              5.heightBox,
              customTextFeild(title: 'Week4 Lab Perfomance: ', hint: 'out of 5', keytype: TextInputType.number, prefixIcon: const Icon(Icons.task), controller: controller.week4LabController),
              'out of 5'.text.color(fontGrey).make(),
              const Divider(),
              5.heightBox,
              customTextFeild(title: 'Week5 Lab Perfomance: ', hint: 'out of out of 5', keytype: TextInputType.number, prefixIcon: const Icon(Icons.task), controller: controller.week5LabController),
              'out of 5'.text.color(fontGrey).make(),
              const Divider(),
              5.heightBox,
              customTextFeild(title: 'Assignment: ', hint: 'out of 10', keytype: TextInputType.number, prefixIcon: const Icon(Icons.assignment), controller: controller.assignmentController),
              'out of 10'.text.color(fontGrey).make(),
              const Divider(),
              5.heightBox,
              customTextFeild(title: 'Project: ', hint: 'out of 25', keytype: TextInputType.number, prefixIcon: const Icon(Icons.build_rounded), controller: controller.projectController),
              'out of 25'.text.color(fontGrey).make(),
              const Divider(),
              5.heightBox,
              customTextFeild(title: 'Lab Final: ', hint: 'out of 30', keytype: TextInputType.number, prefixIcon: const Icon(Icons.edit), controller: controller.labFinalController),
              'out of 30'.text.color(fontGrey).make(),
              const Divider(),
              5.heightBox,
              Obx(() => controller.isloading.value
                ? loadingIndicator()
                : myButton(
                  buttonSize: 20.0,
                  color: Colors.green,
                  textColor: whiteColor,
                  title: 'Save',
                  onPress: (){
                    validator();
                  }
                )
              ),
              10.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
