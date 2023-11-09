import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/ListDataController.dart';
import '../Utils/Reusable_Profile_Image.dart';
import 'Profile_Screen.dart';

class MainListScreen extends StatefulWidget {
  const MainListScreen({Key? key}) : super(key: key);

  @override
  State<MainListScreen> createState() => _MainListScreenState();
}

class _MainListScreenState extends State<MainListScreen> {


  GetDataConroller _gotData = Get.find<GetDataConroller>();

  Future<void> GetListData() async {
    await _gotData.getAllList(context: context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      GetListData();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "List Data",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        child: Obx(
            ()=> ListView.builder(
            padding: EdgeInsets.only(top: 15, bottom: 70),
            shrinkWrap: true,
            itemCount: _gotData.getlistData.value.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Get.to(()=>ProfileUi(UserID: _gotData.getlistData.value.data![index].id.toString(),));
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(189, 238, 238, 238),
                            spreadRadius: 0.2,
                            blurRadius: 8.0,
                            offset: Offset(1.0, 1.0))
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Image.network(_gotData.getlistData.value.data![index].avatar.toString(),fit: BoxFit.cover,), // Change the image path accordingly
                                  );
                                },
                              );
                            },
                            child: ReusableProfileImage(image: _gotData.getlistData.value.data?[index].avatar.toString()??"",)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Full Name:  ${_gotData.getlistData.value.data?[index].firstName.toString()}   ${_gotData.getlistData.value.data?[index].lastName.toString()}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'poppins',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Id:  ${_gotData.getlistData.value.data?[index].id.toString()}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'poppins',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Email:  ${_gotData.getlistData.value.data?[index].email}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'poppins',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
