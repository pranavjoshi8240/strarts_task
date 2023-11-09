import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;
import '../Model/UserDataModel.dart';
import '../Utils/Const_Url.dart';
import '../Utils/Reusable_Snackbar.dart';


class GetUserDataConroller extends GetxController {
  var getUserData = GetUserData().obs;
  var isLoading = true.obs;
  var selectedValue = "".obs;

  Future<void> getUserDataApi({
    required BuildContext context,required String Id}) async {
    SimpleFontelicoProgressDialog dialog =
    SimpleFontelicoProgressDialog(context: context);

    final _url =
    Uri.parse(ConstUrl.baseUrl + ConstUrl.getUserData + Id);
    print(_url.toString());


    //dialog.show(message: "Loading...");
    final response = await http.get(_url);
    print("ppaadd " + response.statusCode.toString());
    print("ppaadd " + response.body.toString());
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      getUserData.value = GetUserData.fromJson(data);
      isLoading.value = false;
      dialog.hide();
    } else {
      isLoading.value = false;
      dialog.hide();
      showSnackBar(title: "Failed", message: data["message"]);
    }
  }
}
