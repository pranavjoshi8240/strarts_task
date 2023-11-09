import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/UserDataController.dart';
import '../Firebase/Firebase_Oprerations.dart';
import '../Utils/Reusable_Button.dart';
import '../Utils/Reusable_Profile_Image.dart';
import '../Utils/Reusable_Snackbar.dart';



class ProfileUi extends StatefulWidget {
  final String UserID;
  const ProfileUi({Key? key, required this.UserID}) : super(key: key);

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  CollectionReference students = FirebaseFirestore.instance.collection('users');
  GetUserDataConroller _gotUserData = Get.find<GetUserDataConroller>();
  String? firebaseId;
  Future<void> fetchDataFromFirestore() async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await usersCollection.get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String id = document.id.toString() ;
      String userName = data['first_name'];
      String userEmail = data['email'];
      print('User Name: $userName, User Email: $userEmail');
      print(id);
      // firebaseId = id;
    }
  }

  Future<void> GetUserData() async {

    await _gotUserData.getUserDataApi(context: context, Id: widget.UserID.toString());
    firstNameCotroller.text = _gotUserData.getUserData.value.data?.firstName.toString()??"";
    secondNameCotroller.text = _gotUserData.getUserData.value.data?.lastName.toString()??"";
    emailCotroller.text = _gotUserData.getUserData.value.data?.email.toString()??"";

  }
  TextEditingController firstNameCotroller = TextEditingController();
  TextEditingController secondNameCotroller = TextEditingController();
  TextEditingController emailCotroller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataFromFirestore();
    GetUserData();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Obx(()=> Text(_gotUserData.getUserData.value.data?.firstName.toString() ?? "")),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Obx(()=> Center(child: Column(
                  children: [
                    ReusableProfileImage(image: _gotUserData.getUserData.value.data?.avatar.toString() ??"",),
                    SizedBox(height: 8,),
                    Obx(()=> Text(_gotUserData.getUserData.value.data?.id.toString() ??"")),
                  ],
                ))),
                SizedBox(height: 50,),
                Text("First Name",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Obx(()=> Text(_gotUserData.getUserData.value.data?.firstName.toString() ??"")),
                SizedBox(height: 20,),
                Text("Last Name",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Obx(()=> Text(_gotUserData.getUserData.value.data?.lastName.toString() ??"")),
                SizedBox(height: 20,),
                Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Obx(()=> Text(_gotUserData.getUserData.value.data?.email.toString() ??"")),
              ],
            ),
          ),
         Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        DatabaseMethods().addUserDetails({
                          "id": int.parse(_gotUserData.getUserData.value.data!.id.toString()),
                          "email": _gotUserData.getUserData.value.data?.email.toString(),
                          "first_name": _gotUserData.getUserData.value.data?.firstName.toString(),
                          "last_name": _gotUserData.getUserData.value.data?.lastName.toString(),
                          "avatar": _gotUserData.getUserData.value.data?.avatar.toString()
                        }).then((value) =>
                            showSnackBar(title: "Done", message: "User Added To Firebase")
                        );
                      },
                        child: ReusableButton(title: 'Add',)),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        QuerySnapshot querySnapshot = await DatabaseMethods().getthisUserInfo(_gotUserData.getUserData.value.data!.firstName.toString());
                        firebaseId = querySnapshot.docs[0].id;
                        await DatabaseMethods().DeleteUserData(firebaseId!).then((value) =>
                           showSnackBar(title: "Done", message: "User Deleted From Firebase")
                       );
                       print("delete");
                      },
                        child: ReusableButton(title: 'Delete',)),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:SizedBox(
                                height: 400,
                                child: Column(children: [
                                  Text("Update Details"),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: firstNameCotroller,
                                    cursorColor: Color(0xff211407),
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.grey.shade300,
                                        //contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: secondNameCotroller,
                                    cursorColor: Color(0xff211407),
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.grey.shade300,
                                        //contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: emailCotroller,
                                    cursorColor: Color(0xff211407),
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.grey.shade300,
                                        //contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(onPressed: () async {
                                   await DatabaseMethods().UpdateUserData(firstNameCotroller.text, secondNameCotroller.text, emailCotroller.text, firebaseId).then((value) async =>
                                       await showSnackBar(title: "Done", message: "User details Updated"),
                                   );
                                   Get.back();
                                  }, child: ReusableButton(title: 'Update',))

                                ],),
                              ));
                          },
                        );
                       // DatabaseMethods().UpdateUserData(age, firebaseId.toString());
                      },
                        child: ReusableButton(title: 'Update',)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
