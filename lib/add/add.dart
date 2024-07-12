// import path and images name

import 'dart:io';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../main.dart';

class AddRoom extends StatefulWidget{
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}
  class _AddRoomState extends State<AddRoom>{

    TextEditingController airCondition_isOn = TextEditingController();
    TextEditingController airCondition_value = TextEditingController();
    TextEditingController airHumidity = TextEditingController();
    TextEditingController imageUrl = TextEditingController();
    TextEditingController lights_isOn = TextEditingController();
    TextEditingController lights_value = TextEditingController();
    TextEditingController name =TextEditingController();
    TextEditingController temperature = TextEditingController();
    TextEditingController timer_isOn = TextEditingController();
    TextEditingController timer_value = TextEditingController();
    bool airCondition = true ;
    bool lights = true ;
    bool timer = true ;
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    File? file;
    String? url;

    getImage()async{
    final ImagePicker picker = ImagePicker();
// Pick an image.
   // final XFile? imagegallery = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
    final XFile? imagephoto = await picker.pickImage(source: ImageSource.camera);
    if(imagephoto!=null){
      file =File(imagephoto!.path);
      var imagename = basename(imagephoto!.path);
      //var imagename = name.text;
      var refStorage = FirebaseStorage.instance.ref("images/$imagename");
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();

    }
    setState(() {

    });
  }

    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');


    addRoom(context)async {
      if(formState.currentState!.validate()){
        try {
          int airConditionValue = int.tryParse(airCondition_value.text) ?? 0;
          int airHumidityValue = int.tryParse(airHumidity.text) ?? 0;
          int lightsValue = int.tryParse(lights_value.text) ?? 0;
          int temperatureValue = int.tryParse(temperature.text) ?? 0;
          int timerValue = int.tryParse(timer_value.text) ?? 0;
        DocumentReference response = await rooms.add(
            {"id": FirebaseAuth.instance.currentUser!.uid,
          'name': name.text,
          'airCondition isOn': airCondition,
          'airCondition value': airConditionValue,
          'airHumidity': airHumidityValue,
          'lights isOn': lights,
          'lights value': lightsValue,
          'temperature': temperatureValue,
          'timer isOn': timer,
          'timer value': timerValue,
          'imageUrl':  url !,});

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
              (route) => false,
        );

      }catch(e){
          AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'error',
          desc: 'there is an error.',
        ).show();

        }}else if (url == null) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'error',
          desc: 'pls choice a picture.',
        ).show();
        setState(() {

        });

        }
    }

    bool isLoading = false;

    @override
    Widget build (BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Text("Add New Room"),),
        body:isLoading
            ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
          child: Form(
            key: formState,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
              decoration: const InputDecoration(
              icon: Icon(Icons.roofing),
              hintText: 'Room Name',
              labelText: 'name',
                      ),
                style: TextStyle(color: Colors.black),
                      onChanged: (value) {
              setState(() {});
                      },
                      validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
                      },
                      controller: name,
                    ),
            ),
                  const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
          decoration: const InputDecoration(
                icon: Icon(Icons.thermostat),
                hintText: 'Room Temperature',
                labelText: 'Temperature',
                ),
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.number, // Ensure numeric input
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // Allow only digits
          ],
                onChanged: (value) {
                setState(() {});
                },
                validator: (value) {
                if (value == null || value.isEmpty) {
                return 'Please enter a Temperature';
                }
                return null;
                },
                controller: temperature,
                ),
              ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.water_drop),
                        hintText: 'airHumidity',
                        labelText: 'airHumiditye',
                      ),
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number, // Ensure numeric input
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a airHumidity value';
                        }
                        return null;
                      },
                      controller: airHumidity,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: SwitchListTile(
                      title: const Text('airCondition'),
                      //subtitle: const Text('airCondition'),
                      secondary: const Icon(Icons.air),
                      value: airCondition,
                      onChanged: (bool value) {
                        setState(() {
                          airCondition = value;
                        });
                      },
                      // You can add validation manually in your form submission logic
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.air),
                        hintText: 'airCondition value',
                        labelText: 'airCondition',
                      ),
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number, // Ensure numeric input
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a airCondition value';
                        }
                        return null;
                      },
                      controller: airCondition_value,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: SwitchListTile(
                      title: const Text('lights'),
                      //subtitle: const Text('airCondition'),
                      secondary: const Icon(Icons.lightbulb_circle),
                      value: lights,
                      onChanged: (bool value) {
                        setState(() {
                          lights = value;
                        });
                      },
                      // You can add validation manually in your form submission logic
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lightbulb_circle_outlined),
                        hintText: 'lights value',
                        labelText: 'lights',
                      ),
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number, // Ensure numeric input
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a lights value';
                        }
                        return null;
                      },
                      controller: lights_value,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: SwitchListTile(
                      title: const Text('timer'),
                      //subtitle: const Text('airCondition'),
                      secondary: const Icon(Icons.timer_outlined),
                      value: timer,
                      onChanged: (bool value) {
                        setState(() {
                          timer = value;
                        });
                      },
                      // You can add validation manually in your form submission logic
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.timer),
                        hintText: 'timer value',
                        labelText: 'timer',
                      ),
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number, // Ensure numeric input
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a airCondition value';
                        }
                        return null;
                      },
                      controller: timer_value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: (()  async{
                          await getImage();
                      }),
                    icon: const Icon(Icons.image,color: Colors.blue),
                    label: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      child: const Text(
                        'pick a picture',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: url==null ? Colors.blue[900] : Colors.green,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                 // if(url!=null)Image.network(url!,width: 100,height: 100,fit: BoxFit.fill,),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: (() async {
                      if (formState.currentState!.validate()){
                        try{
                          isLoading = true;
                          setState(() {});
                         await addRoom(context);
                          isLoading = false;
                          setState(() {});}
                        catch (e) {
                        isLoading = false;
                        setState(() {});}
                    }}),
                    icon: const Icon(Icons.add,color: Colors.blue,),

                    label: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 40,
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ]),
              ),
        ));
  }
  }

