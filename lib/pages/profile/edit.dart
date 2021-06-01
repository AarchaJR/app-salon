// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:projectsalon/constants.dart';
// import 'package:projectsalon/helper/helperfunctions.dart';
// import 'package:projectsalon/services/database.dart';

// class Edit extends StatefulWidget {
//   @override
//   _EditState createState() => _EditState();
// }

// class _EditState extends State<Edit> {
//   File _image;
//   File _image1;

//   DatabaseMethods databaseMethods = new DatabaseMethods();
//   QuerySnapshot searchSnapshot;
//   QuerySnapshot searchSnap;

//   bool dpChange = false;
//   bool tpChange = false;

//   final formKey = GlobalKey<FormState>();

//   TextEditingController newAddressTextEditingController =
//       new TextEditingController();
//   TextEditingController newNumberTextEditingController =
//       new TextEditingController();
//   TextEditingController newFNameTextEditingController =
//       new TextEditingController();
//   TextEditingController newLNameTextEditingController =
//       new TextEditingController();

//   String userName;
//   String address;
//   String phoneNumber;
//   String Fname;
//   String Lname;

//   void initState() {
//     getinfo();
//     super.initState();
//   }

//   getinfo() async {
//     Constants.myName = await HelperFunctions.getUserNameSharedPreference();
//   }

//   editProfile() async {
//     Constants.myName = await HelperFunctions.getUserNameSharedPreference();
//     print(Constants.myName);

//     if (formKey.currentState.validate()) {
//       print('hello');
//       address = newAddressTextEditingController.text.isEmpty
//           ? "nochange"
//           : newAddressTextEditingController.text;

//       Fname = newFNameTextEditingController.text.isEmpty
//           ? "nochange"
//           : newFNameTextEditingController.text;
//       print(Fname);
//       Lname = newLNameTextEditingController.text.isEmpty
//           ? "nochange"
//           : newLNameTextEditingController.text;
//       print(Lname);
//       phoneNumber = newNumberTextEditingController.text.isEmpty
//           ? "nobio"
//           : newNumberTextEditingController.text;
//       databaseMethods.updateUser(
//           Constants.myName, address, Fname, Lname, phoneNumber);
//     }
//   }

//   // dpChange = false;
//   // tpChange = false;

//   getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       _image = image;
//       print("hello ji");
//       print("Image Path $_image");
//       dpChange = true;
//       print(dpChange);
//     });
//   }

//   getImage1() async {
//     var image1 = await ImagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       _image1 = image1;
//       print("hello ji");
//       print("Image Path $_image1");
//       tpChange = true;
//       print(tpChange);
//     });
//   }

//   initiateSearch() {
//     databaseMethods.getUserByUsername(Constants.myName).then((val) {
//       setState(() {
//         if (val != null) searchSnap = val;
//       });
//     });
//   }

//   uploadPic(BuildContext context) async {
//     String fileName = basename(_image.path);
//     initiateSearch();
//     String useremail = searchSnap.docs[0].data()["email"];
//     Reference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('users/$useremail');
//     UploadTask uploadTask = firebaseStorageRef.putFile(_image);
//     //var storage = FirebaseStorage.instance.ref();
//     TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() async {
//       final ref = FirebaseStorage.instance.ref('users/$useremail');
//       var url = await ref.getDownloadURL();
//       print(url);
//       String id = searchSnap.docs[0].id;
//       //print(value);
//       FirebaseFirestore.instance
//           .collection("users")
//           .doc(id)
//           .update({"displaypic": url});
//       setState(() {
//         // print("Profile picture uploaded");
//         //storage.child('gs://campconnectchat.appspot.com/users/$useremail').getDownloadURL().then((value) {

//         //});
//         // Scaffold.of(context).showSnackBar(SnackBar(
//         //   content: Text('Profile picture uploaded'),
//         // ));
//         dpChange = true;
//         if (tpChange)
//           uploadPic1(context);
//         else
//           Navigator.pop(context);
//       });
//     });
//   }

//   uploadPic1(BuildContext context) async {
//     String fileName = basename(_image1.path);
//     initiateSearch();
//     String useremail = searchSnap.docs[0].data()["email"];
//     Reference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('users/timeline_$useremail');
//     UploadTask uploadTask = firebaseStorageRef.putFile(_image1);
//     //var storage = FirebaseStorage.instance.ref();
//     TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() async {
//       final ref = FirebaseStorage.instance.ref('users/timeline_$useremail');
//       var url = await ref.getDownloadURL();
//       print(url);
//       String id = searchSnap.docs[0].id;
//       //print(value);
//       FirebaseFirestore.instance
//           .collection("users")
//           .doc(id)
//           .update({"tpic": url});
//       //});
//       setState(() {
//         // print("Timeline picture uploaded");
//         //storage.child('gs://campconnectchat.appspot.com/users/$useremail').getDownloadURL().then((value) {

//         // Scaffold.of(context).showSnackBar(SnackBar(
//         //   content: Text('Profile picture uploaded'),
//         // ));
//         tpChange = true;
//         Navigator.pop(context);
//       });
//     });
//   }

//   currentdp() {
//     initiateSearch();
//     return searchSnap != null
//         ? searchSnap.docs[0].data()["displaypic"] == ""
//             ? NetworkImage(
//                 "https://slcp.lk/wp-content/uploads/2020/02/no-profile-photo.png")
//             : NetworkImage(searchSnap.docs[0].data()["displaypic"])
//         : NetworkImage(
//             "https://slcp.lk/wp-content/uploads/2020/02/no-profile-photo.png");
//   }

//   currenttp() {
//     initiateSearch();
//     return searchSnap != null
//         ? searchSnap.docs[0].data()["tpic"] == ""
//             ? NetworkImage(
//                 "https://upload.wikimedia.org/wikipedia/commons/6/6c/Black_photo.jpg")
//             : NetworkImage(searchSnap.docs[0].data()["tpic"])
//         : NetworkImage(
//             "https://upload.wikimedia.org/wikipedia/commons/6/6c/Black_photo.jpg");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 150,
//           ),
//           SizedBox(
//             height: 115,
//             width: 115,
//             child: Stack(
//               fit: StackFit.expand,
//               overflow: Overflow.visible,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: _image != null
//                       ?
//                       //Image.file(_image,fit: BoxFit.fill,)
//                       FileImage(File(_image.path))
//                       : currentdp(),
//                 ),
//                 Positioned(
//                   right: -16,
//                   bottom: 0,
//                   child: SizedBox(
//                     height: 46,
//                     width: 46,
//                     child: FlatButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         side: BorderSide(color: Colors.white),
//                       ),
//                       color: Color(0xFFF5F6F9),
//                       onPressed: () {
//                         // print(dpChange);
//                         // setState(() {
//                         //   dpChange = true;
//                         // });
//                         // getImage();
//                       },
//                       child: Image.asset("assets/images/camera.png"),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       border:
//                           Border(bottom: BorderSide(color: Colors.grey[200]))),
//                   child: TextFormField(
//                     validator: (val) {
//                       return val.isEmpty
//                           ? 'Please provide a valid First Name'
//                           : null;
//                     },
//                     controller: newFNameTextEditingController,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "First Name",
//                         hintStyle: TextStyle(color: Colors.grey)),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       border:
//                           Border(bottom: BorderSide(color: Colors.grey[200]))),
//                   child: TextFormField(
//                     validator: (val) {
//                       return val.isEmpty
//                           ? 'Please provide a valid Last Name'
//                           : null;
//                     },
//                     controller: newLNameTextEditingController,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Last Name",
//                         hintStyle: TextStyle(color: Colors.grey)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
