import 'package:custom_bottom_nav_01/home_screen.dart';
import 'package:custom_bottom_nav_01/notification_screen.dart';
import 'package:custom_bottom_nav_01/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CustomBottom Navigation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentIndex = 0;
  PageStorageBucket bucket = PageStorageBucket();

  List<BottomModel> item = [
    BottomModel(
      title: 'Home',
      activeIcon: 'assets/images/1.png',
      inActiveIcon: 'assets/images/2.png',
      screen: const HomeScreen(),
    ),

    BottomModel(
      title: 'Notification',
      activeIcon: 'assets/images/3.png',
      inActiveIcon: 'assets/images/4.png',
      screen: const NotificationScreen(),
    ),
    BottomModel(
      title: 'Profile',
      activeIcon: 'assets/images/5.png',
      inActiveIcon: 'assets/images/6.png',
      screen: const ProfileScreen(),
    ),
  ];

  void setCurrentIndex(int index){
    setState(() {
      currentIndex =  index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          PageStorage(bucket: bucket, child: item[currentIndex].screen),

          Positioned(child: Align(alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor),
                  height: 65,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: generateBottomItem(item)),
              ),
            ),))
        ],
      ),

    );
  }
  List<Widget> generateBottomItem (List<BottomModel> item){
    List<Widget> items = [];
    for(int i =0; i< item.length; i++){
      items.add(CustomMenuItem(isSelected: currentIndex == i,
      title: item[i].title, activeIcon: item[i].activeIcon,
        inActiveIcon: item[i].inActiveIcon,
        onTap: () {
        setState(() {
          setCurrentIndex(i);
        });
        },));
    }
    return items;
  }

}

class BottomModel{
  final String title;
  final String activeIcon;
  final String inActiveIcon;
  final Widget screen;

  BottomModel({required this.title, required this.activeIcon, required this.inActiveIcon, required this.screen});
}

class CustomMenuItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String activeIcon;
  final String inActiveIcon;
  final VoidCallback onTap;
  const CustomMenuItem({Key? key, required this.isSelected, required this.title, required this.activeIcon, required this.inActiveIcon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          SizedBox(width: isSelected? 20 : 35, child: Image.asset(isSelected? activeIcon : inActiveIcon, color: isSelected? Colors.white:  Colors.grey)),
          if(isSelected)
            Text(title, style: const TextStyle(color: Colors.white))
        ],),
      ),
    );
  }
}
