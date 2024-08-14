import 'package:flutter/material.dart';
import 'package:smart_home/add/add.dart';

import '../../../../core/app/app.dart';
import '../../../../core/core.dart';
import '../../../../dashboard/dashboardtemp.dart';
import '../../../../settings/settings.dart';

class SmHomeBottomNavigationBar extends StatelessWidget {
  const SmHomeBottomNavigationBar({
    super.key,
    required this.roomSelectorNotifier,
  });

  final ValueNotifier<int> roomSelectorNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ValueListenableBuilder<int>(
        valueListenable: roomSelectorNotifier,
        builder: (_, value, child) => AnimatedOpacity(
          duration: kThemeAnimationDuration,
          opacity: value != -1 ? 0 : 1,
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            transform:
                Matrix4.translationValues(0, value != -1 ? -30.0 : 0.0, 0),
            child: child,
          ),
        ),
        child: BottomNavigationBar(
          items: const [

            BottomNavigationBarItem(

              icon: Padding(

                padding: EdgeInsets.all(8),
                child: Icon(SHIcons.home),
              ),

              label: 'MAIN',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.add),
              ),
              label: 'ADD ROOM',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.dashboard),
              ),
              label: 'DASHBOARD',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(SHIcons.settings),
              ),
              label: 'SETTINGS',
            ),
          ],
          onTap: (index) {
            if (index == 0) { // assuming the home icon is at index 0
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SmartHomeApp(),
                ),
              );
            }else if (index == 1) { // assuming the home icon is at index 0
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRoom(),
                ),
              );
            }else if (index == 2) { // assuming the home icon is at index 0
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemperatureChart(),
                ),
              );
            }else{ // assuming the home icon is at index 0
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
