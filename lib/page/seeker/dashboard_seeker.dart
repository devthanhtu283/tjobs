import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/page/seeker/connect_seeker.dart';
import 'package:job/page/seeker/cv_profile_seeker.dart';
import 'package:job/page/seeker/home_seeker.dart';
import 'package:job/page/seeker/notification_seeker.dart';
import 'package:job/page/seeker/profile_seeker.dart';



class DashboardSeekerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.rectangle_paperclip),
            label: 'CV&Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2_fill),
            label: 'Connect',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.app_badge_fill),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: HomePage(),
                  ),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: CVProfilePage(),
                  ),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: ConnectSeekerPage(),
                  ),
                );
              },
            );
          case 3:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: NotificationSeekerPage(),
                  ),
                );
              },
            );
          case 4:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: ProfileSeekerPage(),
                  ),
                );
              },
            );
          default:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Trang chủ'),
                  ),
                  child: Center(
                    child: Text('Nội dung trang chủ'),
                  ),
                );
              },
            );
        }
      },
    );
  }
}