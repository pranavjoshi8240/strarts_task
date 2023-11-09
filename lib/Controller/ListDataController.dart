import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;
import '../Model/ListDataModel.dart';
import '../Utils/Const_Url.dart';
import '../Utils/Reusable_Snackbar.dart';


class GetDataConroller extends GetxController {
  var getlistData = GetListData().obs;
  var isLoading = true.obs;
  var selectedValue = "".obs;

  Future<void> getAllList({
    required BuildContext context,}) async {
    SimpleFontelicoProgressDialog dialog =
    SimpleFontelicoProgressDialog(context: context);

    final _url =
    Uri.parse(ConstUrl.baseUrl + ConstUrl.getData + "2");
    print(_url.toString());


    dialog.show(message: "Loading...");
    final response = await http.get(_url);
    print("ppaadd " + response.statusCode.toString());
    print("ppaadd " + response.body.toString());
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      getlistData.value = GetListData.fromJson(data);

      isLoading.value = false;
      dialog.hide();
    } else {
      isLoading.value = false;
      dialog.hide();
      showSnackBar(title: "Failed", message: data["message"]);
    }
  }
}
