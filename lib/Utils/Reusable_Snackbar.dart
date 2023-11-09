import 'package:get/get.dart';

showSnackBar({required String title, required String message, int duration = 3})
{
  return


    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message:  message,
        duration:  Duration(seconds: duration),
      ),
    );
}
