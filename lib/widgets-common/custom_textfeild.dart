import 'package:diu_lab_management/const/consts.dart';

Widget customTextFeild({
  required String? title,
  required String? hint,
  Widget? prefixIcon,
  controller,
  keytype,
  readOnly = false,
  onTap,
  maxLength
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TextFormField(
        onTap: onTap,
        maxLength: maxLength,
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
            fontSize: 20,
          ),
          hintText: hint,
          isDense: true,
          fillColor: whiteColor,
          filled: true,
          border:  OutlineInputBorder(
            borderSide: const BorderSide(color: highEmphasis),
            borderRadius: BorderRadius.circular(50.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary),
            borderRadius: BorderRadius.circular(50.0)
          ),
        ),
        keyboardType: keytype,
      ),
      5.heightBox,
    ],
  );
}
