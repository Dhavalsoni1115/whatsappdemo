// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappdemo/constnts.dart';
import 'package:whatsappdemo/data/firestore_data.dart';
import 'package:whatsappdemo/widgets/list_tile_card.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic userId, userName, userEmail, userPassword;
  const ProfileScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageUrl;
  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProfileImage/${widget.userName}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
          addProfileImage(
            docId: widget.userId,
            name: widget.userName,
            email: widget.userEmail,
            password: widget.userPassword,
            profileImage: imageUrl.toString(),
          );
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  dynamic userData;
  Future<dynamic> getCurrentUserData() async {
    dynamic userData1 =
        await getCurrentUserAllDetail(docId: widget.userId.toString());
    setState(() {
      userData = userData1;
    });
    return userData;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: appBarColor,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Center(
                    child: userData == null
                        ? const SpinKitThreeInOut(
                            color: appBarColor, size: 60.0)
                        : imageUrl == null
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    NetworkImage(userData?['profileImage']),
                                //  child: Image(image: FileImage(imageFile!),fit: BoxFit.cover,),//backgroundColor: Colors.amber,
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    NetworkImage(imageUrl.toString()),
                                //  child: Image(image: FileImage(imageFile!),fit: BoxFit.cover,),//backgroundColor: Colors.amber,
                              )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 125, left: 210),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      uploadImage();
                    });
                  },
                  child: const CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.green,
                    child: Center(
                        child: Icon(Icons.camera_alt_sharp,
                            color: Colors.white, size: 30)),
                  ),
                ),
              )
            ],
          ),
          ListTileCard(
            circleAvtarChild: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            listtileTitle: const Text(
              'Name',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            listtileSubTitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                    'This is not your username or pin. This name will be visible to your WhatsApp contacts.'),
              ],
            ),
            listtileDate: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          const ListTileCard(
            circleAvtarChild: Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
            listtileTitle: Text(
              'About',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            listtileSubTitle: Text('......'),
            listtileDate: Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          const ListTileCard(
            circleAvtarChild: Icon(
              Icons.phone,
              color: Colors.grey,
            ),
            listtileTitle: Text(
              'Phone',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            listtileSubTitle: Text('+91 8320069125'),
            listtileDate: Text(''),
          ),
        ],
      ),
    );
  }
}
