
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inuny/helpers.dart';
import 'package:inuny/pages/calls_page.dart';
import 'package:inuny/pages/contacts_page.dart';
import 'package:inuny/pages/messages_page.dart';
import 'package:inuny/pages/notifications_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:inuny/theme.dart';
import 'package:inuny/widgets/avatar.dart';
import 'package:inuny/widgets/glowing_action_button.dart';
import 'package:inuny/widgets/icons_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = const [
    MessagesPage(),
    CallsPage(),
    NotificationsPage(),
    ContactsPage(),
  ];

  final pageTitle = [
    'Messages',
    'Calls',
    'Notifications',
    'Contacts'
  ];
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(icon: Icons.search,
          onTap: (){},),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:24.0),
            child: Avatar.small(url: Helpers.randomPictureUrl(),),
          )],
      ),

      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(onItemSelected: (i){
        setState(() {
          index = i;
        });
      },),
    );
  }
}

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({super.key,
  required this.onItemSelected
  });


  final ValueChanged<int> onItemSelected;

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  var selectedIndex = 0;

 void handleItemSelected(int index){

  setState(() {
    selectedIndex = index;
  });
  widget.onItemSelected;

 }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:  [
          NavigationBarItem(
           
           
            lable: 'Messages', 
          icon: CupertinoIcons.bubble_left_bubble_right_fill,
           index: 0,
           isSelected: (selectedIndex == 0),
            onTap: handleItemSelected,),
          
           NavigationBarItem(
            
           
            lable: 'Notifications', icon: CupertinoIcons.bell_solid,
             isSelected: (selectedIndex == 1),
            index: 1,onTap: handleItemSelected,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: GlowingActionButton(color: AppColors.secondary, icon: CupertinoIcons.add, onPressed: (){}),
            ),
            NavigationBarItem(
             
              index: 2,
               isSelected: (selectedIndex == 2),
              lable: 'calls', icon: CupertinoIcons.phone_fill,
               onTap: handleItemSelected,),
             NavigationBarItem(
              onTap: handleItemSelected,
              index:3,
               isSelected: (selectedIndex == 3),
              lable: 'Contacts', icon: CupertinoIcons.person_2_fill)
        ],
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({super.key, 
  required this.lable,
  required this.icon,
  required this.index,
  this.isSelected = false,
  required this.onTap,

  });

 
  final String lable;
  final IconData icon;
  final int index;
  final ValueChanged<int> onTap; 
  final bool isSelected;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () {
        onTap(index);
        
      },
      child: SizedBox(
        width: 70,
        child: Column(
         mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
            color: isSelected ? AppColors.secondary : null),
            SizedBox(height: 8,),
            Text(lable, style:  TextStyle(fontSize: 11),),
          ],
        ),
      ),
    );
  }
}