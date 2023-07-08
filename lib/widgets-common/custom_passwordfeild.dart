import 'package:diu_lab_management/const/consts.dart';

Widget customPasswordFeild({
  required String? title,
  required String? hint,
  bool obsText = false,
  suffixIcon,
  controller
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      title!.text
          .color(highEmphasis)
          .fontFamily(semibold)
          .size(20)
          .make(),
      5.heightBox,
      TextFormField(
        obscureText: obsText,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outlined, size: 25,),
          suffixIcon: suffixIcon,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
            fontSize: 20,
          ),
          hintText: hint,
          isDense: true,
          fillColor: whiteColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: highEmphasis),
            borderRadius: BorderRadius.circular(50.0)
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: highEmphasis),
            borderRadius: BorderRadius.circular(50.0)
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}

