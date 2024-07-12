import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../add/update.dart';
import '../../../../core/shared/domain/entities/music_info.dart';
import '../../../../core/shared/domain/entities/smart_device.dart';
import '../../../../core/shared/domain/entities/smart_room.dart';
import '../../../../core/shared/presentation/widgets/room_card.dart';
import '../../../../main.dart';
import '../../../smart_room/screens/room_details_screen.dart';

class SmartRoomsPageView extends StatefulWidget {
  final ValueNotifier<double> pageNotifier;
  final ValueNotifier<int> roomSelectorNotifier;
  final PageController controller;

  const SmartRoomsPageView({
    Key? key,
    required this.pageNotifier,
    required this.roomSelectorNotifier,
    required this.controller,
  }) : super(key: key);

  @override
  State<SmartRoomsPageView> createState() => _SmartRoomsPageViewState();
}

class _SmartRoomsPageViewState extends State<SmartRoomsPageView> {
  List<SmartRoom> rooms = [];
  bool isLoading = true ;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("rooms").where("id", isEqualTo:FirebaseAuth.instance.currentUser!.uid).get();
    List<SmartRoom> fetchedRooms = querySnapshot.docs.map((doc) {
      return SmartRoom(
        id: doc.id,
        name: doc["name"],
       imageUrl: doc["imageUrl"],
       // imageUrl: 'assets/images/0.jpeg',

        temperature: doc["temperature"].toDouble(),
        airHumidity: doc["airHumidity"].toDouble(),
        lights: SmartDevice(isOn: doc["lights isOn"], value: doc["lights value"]),
        timer: SmartDevice(isOn: doc["timer isOn"], value: doc["timer value"]),
        airCondition: SmartDevice(isOn: doc["airCondition isOn"], value: doc["airCondition value"]),
        //musicInfo: MusicInfo(
          //isOn: doc["musicInfo"]["isOn"],
          //currentSong: Song.defaultSong, // Adjust this based on your Song class
        //),
        //lights: SmartDevice(isOn: true, value: 40),
        //timer: SmartDevice(isOn: false, value: 20),
        //airCondition: SmartDevice(isOn: true, value: 10),
        musicInfo: MusicInfo(
          isOn: false,
          currentSong: Song.defaultSong,
        ),
      );
    }).toList();
    isLoading = false;

    setState(() {
      rooms = fetchedRooms;
      SmartRoom.fakeValues = fetchedRooms;
      print("==========================${rooms.length}");// Update the fake values
    });
  }
  double _getOffsetX(double percent) => percent.isNegative ? 30.0 : -30.0;

  Matrix4 _getOutTranslate(double percent, int selected, int index) {
    final x = selected != index && selected != -1 ? _getOffsetX(percent) : 0.0;
    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true ? Center(child: CircularProgressIndicator()) : ValueListenableBuilder<double>(
      valueListenable: widget.pageNotifier,
      builder: (_, page, __) => ValueListenableBuilder(
        valueListenable: widget.roomSelectorNotifier,
        builder: (_, selected, __) => PageView.builder(
          clipBehavior: Clip.none,
          itemCount: rooms.length,
          controller: widget.controller,
          itemBuilder: (_, index) {
            final percent = page - index;
            final isSelected = selected == index;
            final room = rooms[index];
            return AnimatedContainer(
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              transform: _getOutTranslate(percent, selected as int, index),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onLongPress: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: 'warning',
                    desc: 'do u wanna delete or change room details',
                    btnCancelText: "delete",
                    btnOkText: "update",
                    btnCancelOnPress: ()async{
                      await FirebaseFirestore.instance.collection("rooms").doc(rooms[index].id).delete();
                      if(rooms[index].imageUrl.startsWith('https'))
                          { FirebaseStorage.instance.refFromURL(rooms[index].imageUrl).delete();}
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                            (route) => false,
                      );
                    },
                    btnOkOnPress: ()async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateRoom(docid: rooms[index].id, oldname: rooms[index].name,),
                        ),

                      );

                    }
                  ).show();
                },
                child: RoomCard(
                  percent: percent,
                  expand: isSelected,
                  room: room,
                  onSwipeUp: () => widget.roomSelectorNotifier.value = index,
                  onSwipeDown: () => widget.roomSelectorNotifier.value = -1,
                  onTap: () async {
                    if (isSelected) {
                      await Navigator.push(
                        context,
                        PageRouteBuilder<void>(
                          transitionDuration: const Duration(milliseconds: 800),
                          reverseTransitionDuration: const Duration(milliseconds: 800),
                          pageBuilder: (_, animation, __) => FadeTransition(
                            opacity: animation,
                            child: RoomDetailScreen(room: room),
                          ),
                        ),
                      );
                      widget.roomSelectorNotifier.value = -1;
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
