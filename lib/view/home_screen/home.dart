import 'package:diu_lab_management/const/consts.dart';
import 'package:diu_lab_management/const/images.dart';
import 'package:diu_lab_management/widgets-common/appbar_widget.dart';
import 'package:diu_lab_management/widgets-common/end_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {

    List<Widget> items = [
      Image.asset(imgLab1, fit: BoxFit.cover).box.clip(Clip.antiAlias).rounded.make(),
      Image.asset(imgLab2, fit: BoxFit.cover).box.clip(Clip.antiAlias).rounded.make(),
      Image.asset(imgLab3, fit: BoxFit.cover).box.clip(Clip.antiAlias).rounded.make(),
    ];

    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: 'Dahsboard'
      ),
      endDrawer: drawerWidget(context.screenWidth),
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
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
                Image.asset(icApplogo, height: 200,),
                10.heightBox,
                'Welcome To DIU Lab Management'.text.size(20).bold.color(highEmphasis).make(),
                10.heightBox,
                Builder(
                  builder: (context) => 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      'Start Evaluation'.text.white.semiBold.size(25).make(),
                      Image.asset(icRight, color: whiteColor, height: 15),
                    ],
                  ).box.rounded.color(Colors.green).shadow.padding(const EdgeInsets.all(16.0)).make().onTap(() {
                    Scaffold.of(context).openEndDrawer();
                  })
                ),
                10.heightBox,
                'Quick Links'.text.size(20).bold.color(highEmphasis).make(),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(icBus,height: 50,),
                        'Schedule'.text.semiBold.color(highEmphasis).size(20).make(),
                      ],
                    ).box.width(context.screenWidth*0.5-20).shadow.white.rounded.padding(const EdgeInsets.all(8.0)).make()
                    .onTap(()async{
                      final Uri url = Uri.parse('https://daffodilvarsity.edu.bd/article/transport');
                      if (!await launchUrl(url, mode:  LaunchMode.externalApplication)) {
                        // await launchUrl(url);
                        throw Exception('Could not launch $url');
                      }
                    })
                    ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(icResults,height: 50,),
                        'Result'.text.semiBold.color(highEmphasis).size(20).make(),
                      ],
                    ).box.width(context.screenWidth*0.5-20).shadow.white.rounded.padding(const EdgeInsets.all(8.0)).make()
                    .onTap(()async{
                      final Uri url = Uri.parse('http://studentportal.diu.edu.bd/#/result');
                      if (!await launchUrl(url, mode:  LaunchMode.externalApplication)) {
                        // await launchUrl(url);
                        throw Exception('Could not launch $url');
                      }
                    }),
                  ],
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(icBook,height: 50,),
                        'Library'.text.semiBold.color(highEmphasis).size(20).make(),
                      ],
                    ).box.width(context.screenWidth*0.5-20).shadow.white.rounded.padding(const EdgeInsets.all(8.0)).make()
                    .onTap(()async{
                      final Uri url = Uri.parse('http://library.daffodilvarsity.edu.bd/');
                      if (!await launchUrl(url, mode:  LaunchMode.externalApplication)) {
                        // await launchUrl(url);
                        throw Exception('Could not launch $url');
                      }
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(icIt,height: 50,),
                        'IT Support'.text.semiBold.color(highEmphasis).size(20).make(),
                      ],
                    ).box.width(context.screenWidth*0.5-20).shadow.white.rounded.padding(const EdgeInsets.all(8.0)).make()
                    .onTap(()async{
                      final Uri url = Uri.parse('https://daffodilvarsity.edu.bd/staff/attendant');
                      if (!await launchUrl(url, mode:  LaunchMode.externalApplication)) {
                        // await launchUrl(url);
                        throw Exception('Could not launch $url');
                      }
                    }),
                  ],
                ),
                30.heightBox,
                VxSwiper(
                  items: items,
                  height: 200,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
