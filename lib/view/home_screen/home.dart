import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/widgets-common/appbar_widget.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: 'Dahsboard'
      ),
      endDrawer: drawerWidget(context.screenWidth),
      body: Container(
        width: context.screenWidth,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icApplogo, height: 200,),
              'Welcome To DIU Lab Management'.text.size(20).bold.color(highEmphasis).make(),
              10.heightBox,
              Builder(
                builder: (context) => Image.asset(icRight, color: whiteColor, height: 40,).box.roundedFull.color(highEmphasis).padding(const EdgeInsets.all(16.0)).make().onTap(() {
                  Scaffold.of(context).openEndDrawer();
                })
              )
            ],
          ),
        ),
      ),
    );
  }
}
