import 'package:diu_lab_management/const/consts.dart';
class FireStoreServices{
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }
  static getCourse(){
    return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection(semesterCollection)
          .snapshots();
  }
  static getStudents(courseId){
    return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('course')
          .doc(courseId)
          .collection('students')
          .snapshots();
  }
  static getStudentDetails(courseId, studentId){
    return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('course')
          .doc(courseId)
          .collection('students')
          .doc(studentId)
          .snapshots();
  }

  static getCoursesHomePage(){
    return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('course')
          .snapshots();
  }
}
