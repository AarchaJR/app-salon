import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:projectsalon/constants.dart';
import 'package:projectsalon/helper/helperfunctions.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUsernameForSearch(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("searchname", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  getSalonBySalonname(String salonname) async {
    return await FirebaseFirestore.instance
        .collection("salons")
        .where("name", isEqualTo: salonname)
        .get();
  }

  getUsersOnSearch() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  getSalonsOnSearch() async {
    return await FirebaseFirestore.instance.collection("salons").get();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .get();
    //.snapshots();
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  updatePost(String username) async {
    QuerySnapshot docRef = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
    String x = docRef.docs[0].id;
    String y = docRef.docs[0].data()["posts"];
    int z = int.parse(y);
    z = z + 1;
    FirebaseFirestore.instance
        .collection("users")
        .doc(x)
        .update({"posts": "$z"});
  }

  getUserSpecificFeed(String username) async {
    QuerySnapshot docRef = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
    String email = docRef.docs[0].data()["email"];
    print(email);
    return await FirebaseFirestore.instance
        .collection("feed")
        .where("uploader", isEqualTo: email)
        .orderBy("time", descending: true)
        .get();
  }

  // updateUser(String name, String address, String fname, String lname,
  //     String phoneNumber) async {
  //   QuerySnapshot docRef = await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("name", isEqualTo: name)
  //       .get();
  //   String x = docRef.docs[0].id;

  //   if (address != "nochange") {
  //     FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(x)
  //         .update({"address": address});
  //   }

  //   if (fname != "nochange")
  //     FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(x)
  //         .update({"fname": fname});

  //   if (lname != "nochange")
  //     FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(x)
  //         .update({"lname": lname});

  //   if (phoneNumber != "nobio")
  //     FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(x)
  //         .update({"phonenumber": phoneNumber});
  // }

  Future<bool> isUserFollowing(String user, String current) async {
    QuerySnapshot snap;
    snap = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: current)
        .where("ifollowthem", arrayContains: user)
        .get();
    print(snap.size);
    if (snap.size == 1) {
      //print('he');
      return true;
    } else {
      //print('ne');
      return false;
    }
  }

  Future toggleFollow(String user, String current, String currentEmail) async {
    QuerySnapshot snap;
    snap = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: current)
        .where("ifollowthem", arrayContains: user)
        .get();
    //print(snap.size);

    if (snap.size == 1) {
      QuerySnapshot docRef = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: user)
          .get();
      String x = docRef.docs[0].id;
      QuerySnapshot docRef1 = await FirebaseFirestore.instance
          .collection("users")
          .where("name", isEqualTo: current)
          .get();
      String y = docRef1.docs[0].id;

      List p = docRef1.docs[0].data()["ifollowthem"];
      List q = docRef.docs[0].data()["followsme"];

      int m = p.length;
      m = m - 1;
      int n = q.length;
      n = n - 1;

      print(docRef1.docs[0].data()["ifollowthem"]);

      await FirebaseFirestore.instance.collection("users").doc(y).update({
        "ifollowthem": FieldValue.arrayRemove([user])
      });

      await FirebaseFirestore.instance.collection("users").doc(x).update({
        "followsme": FieldValue.arrayRemove([currentEmail])
      });

      FirebaseFirestore.instance
          .collection("users")
          .doc(y)
          .update({"following": "$m"});
      FirebaseFirestore.instance
          .collection("users")
          .doc(x)
          .update({"followers": "$n"});
    } else {
      QuerySnapshot docRef = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: user)
          .get();
      String x = docRef.docs[0].id;
      QuerySnapshot docRef1 = await FirebaseFirestore.instance
          .collection("users")
          .where("name", isEqualTo: current)
          .get();
      String y = docRef1.docs[0].id;

      List p = docRef1.docs[0].data()["ifollowthem"];
      List q = docRef.docs[0].data()["followsme"];

      int m = p.length;
      m = m + 1;
      int n = q.length;
      n = n + 1;

      print(docRef1.docs[0].data()["ifollowthem"]);

      await FirebaseFirestore.instance.collection("users").doc(y).update({
        "ifollowthem": FieldValue.arrayUnion([user])
      });

      await FirebaseFirestore.instance.collection("users").doc(x).update({
        "followsme": FieldValue.arrayUnion([currentEmail])
      });

      FirebaseFirestore.instance
          .collection("users")
          .doc(y)
          .update({"following": "$m"});
      FirebaseFirestore.instance
          .collection("users")
          .doc(x)
          .update({"followers": "$n"});
    }
  }

  getFeed(String username) async {
    QuerySnapshot docRef = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
    String email = docRef.docs[0].data()["email"];
    print(email);
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("feed")
        .orderBy("time", descending: true)
        .get();
    List p = docRef.docs[0].data()["ifollowthem"];
    if (p.length > 0) {
      // p.add(email);
      // print(p);
      // print(p.length);
      // print(p[0]);
      // print(p[1]);
      // print(snap.docs.length);
      //
      // int i,j;
      // for(i=0;i<p.length;i++)
      //   for(j=0;j<snap.docs.length;j++)
      //     if(snap.docs[j].data()["uploader"] == p[i]) {
      //       print(p[i]);
      return snap;
      //}
      //   return await FirebaseFirestore.instance.collection('feed')
      // .where("uploader",arrayContainsAny: p).get();
    } else {
      return await FirebaseFirestore.instance
          .collection("feed")
          .where("uploader", isEqualTo: email)
          .orderBy("time", descending: true)
          .get();
    }
  }

  getNoOfPosts(String username) async {
    QuerySnapshot docRef = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
    String email = docRef.docs[0].data()["email"];
    List p = docRef.docs[0].data()["ifollowthem"];
    QuerySnapshot doc1;
    int i;
    int j = 0;
    if (p.length > 0) {
      p.add(email);
      for (i = 0; i < p.length; i++) {
        doc1 = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: p[i])
            .get();
        j = j + int.parse(doc1.docs[0].data()["posts"]);
      }
      return j;
    } else
      return 0;
  }

  getFollowers(String username) async {
    QuerySnapshot docRef = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
    String email = docRef.docs[0].data()["email"];
    List p = docRef.docs[0].data()["ifollowthem"];
    p.add(email);
    return p;
  }

  String checking(String username) {
    FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        return result.data()["name"];
      });
    });
  }
}
