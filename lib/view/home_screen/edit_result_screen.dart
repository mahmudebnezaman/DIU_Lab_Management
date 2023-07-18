import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/loading_indicator.dart';
import 'package:diu_lab_management/controller/semester_controller.dart';
import 'package:diu_lab_management/widgets-common/appbar_widget.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';
import 'package:diu_lab_management/widgets-common/my_button.dart';

class EditResultScreen extends StatefulWidget {
  final dynamic data;
  final dynamic courseID;

  const EditResultScreen({Key? key, required this.data,  required this.courseID}) : super(key: key);

  @override
  State<EditResultScreen> createState() => _EditResultScreenState();
}

class _EditResultScreenState extends State<EditResultScreen> {
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
        controller.editStudentResult(widget.courseID, widget.data.id);
        VxToast.show(context, msg: 'Result Updated');
        Get.back();
      }
    }

    return Scaffold(
      appBar:appBarWidget(context: context, title: 'Evaluate Result'),
      endDrawer: drawerWidget(context.screenWidth),
      body:Container(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                '${widget.data['id']}'.text.color(Colors.green).bold.size(22).make(),
                10.heightBox,
                Row(
                  children: [
                  'Week One Lab Mark:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 1,
                      controller: controller.week1LabController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 5'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                Row(
                  children: [
                  'Week Two Lab Mark:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 1,
                      controller: controller.week2LabController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 5'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                Row(
                  children: [
                  'Week Three Lab Mark:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 1,
                      controller: controller.week3LabController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 5'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                Row(
                  children: [
                  'Week Four Lab Mark:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 1,
                      controller: controller.week4LabController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 5'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                Row(
                  children: [
                  'Week Five Lab Mark:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 1,
                      controller: controller.week5LabController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 5'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                Row(
                  children: [
                  'Assignment:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 2,
                      controller: controller.assignmentController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 10'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                Row(
                  children: [
                  'Project:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 2,
                      controller: controller.projectController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 25'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                Row(
                  children: [
                  'Lab Final:'.text.semiBold.color(primary).size(18).make(),
                  5.widthBox,
                  SizedBox(
                    width: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: primary,
                        ),
                        isDense: true,
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: highEmphasis),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                        ),
                      ),
                      maxLength: 2,
                      controller: controller.labFinalController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  5.widthBox,
                  'out of 30'.text.color(fontGrey).make(),
                  ],
                ),
                5.heightBox,
                // 5.heightBox,
                // customTextFeild(title: 'Assignment: ', hint: 'out of 10', keytype: TextInputType.number, prefixIcon: const Icon(Icons.assignment), controller: controller.assignmentController),
                // 'out of 10'.text.color(fontGrey).make(),
                // const Divider(),
                // 5.heightBox,
                // customTextFeild(title: 'Project: ', hint: 'out of 25', keytype: TextInputType.number, prefixIcon: const Icon(Icons.build_rounded), controller: controller.projectController),
                // 'out of 25'.text.color(fontGrey).make(),
                // const Divider(),
                // 5.heightBox,
                // customTextFeild(title: 'Lab Final: ', hint: 'out of 30', keytype: TextInputType.number, prefixIcon: const Icon(Icons.edit), controller: controller.labFinalController),
                // 'out of 30'.text.color(fontGrey).make(),
                // const Divider(),
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
      ),
    );
  }
}
