import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc()
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getthisUserInfo(String name) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("first_name", isEqualTo: name)
        .get();
  }

  Future UpdateUserData(String firstName,secondName,email, id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"email": email.toString(),"first_name":firstName.toString(),"last_name":secondName.toString()});
  }

  Future DeleteUserData(String id)async{
    return await FirebaseFirestore.instance.collection("users").doc(id).delete();
  }
}