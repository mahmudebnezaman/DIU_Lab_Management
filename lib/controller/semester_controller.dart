// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_lab_management/const/consts.dart';
class SemesterController extends GetxController {
  final RxBool isloading = false.obs;
  final semesterNameController = ''.obs;
  var courseNameController = TextEditingController();
  var studentIdController = TextEditingController();

  var week1LabController = TextEditingController();
  var week2LabController = TextEditingController();
  var week3LabController = TextEditingController();
  var week4LabController = TextEditingController();
  var week5LabController = TextEditingController();
  var assignmentController = TextEditingController();
  var projectController = TextEditingController();
  var labFinalController = TextEditingController();


  Future<void> editStudentResult(String courseId, String studentId) async {
  try {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('course')
        .doc(courseId)
        .collection('students')
        .doc(studentId)
        .set({
          'week_one_lp': week1LabController.text,
          'week_two_lp': week2LabController.text,
          'week_three_lp': week3LabController.text,
          'week_four_lp': week4LabController.text,
          'week_five_lp': week5LabController.text,
          'assignment': assignmentController.text,
          'project': projectController.text,
          'lab_final': labFinalController.text
        }, SetOptions(merge: true));
    isloading.value = false;
  } catch (e) {
    print('Error registering new student: $e');
    isloading.value = false;
  }
}

}
