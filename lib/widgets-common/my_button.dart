import 'package:diu_lab_management/const/consts.dart';

Widget myButton({onPress, color, textColor, String? title , buttonSize}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor).size(buttonSize).fontFamily(bold).make(),
  );
}