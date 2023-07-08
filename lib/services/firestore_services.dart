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
  static getSection(docId){
    return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('course')
          .doc(docId)
          .collection('section')
          .snapshots();
  }
  static getStudents(docId, courseId){
    return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('course')
          .doc(docId)
          .collection('section')
          .doc(courseId)
          .collection('students')
          .snapshots();
  }
  static getStudentDetails(docId, courseId, studentId){
    return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('course')
          .doc(docId)
          .collection('section')
          .doc(courseId)
          .collection('students')
          .doc(studentId)
          .snapshots();
  }
}
