import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/view/home_screen/home.dart';
AppBar appBarWidget({context,String? title}){
  return AppBar(
    title: title!.text.makeCentered(),
    actions: [Builder(
      builder: (context) => Image.asset(icMenu, color: highEmphasis,).box.padding(const EdgeInsets.all(8.0)).make().onTap(() {
        Scaffold.of(context).openEndDrawer();
      })
    )],
    leading: Image.asset(icApplogo).onTap(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }).box.margin(const EdgeInsets.only(left: 8)).make(),
  );
}