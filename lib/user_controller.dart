import 'package:get/get.dart';
import 'package:getx/user_model.dart';

class UserController extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  void setUserName(String userName) {
    // uma opção
    // user.update((val) {
    //   val?.name = userName;
    // });
    // outra opção
    user.value.name = userName;
    user.refresh();
  }

  void setUserAge(int userAge) {
    user.update((val) {
      val?.age = userAge;
    });
    // user.value.age = userAge;
  }
}
