import 'package:get/get.dart';
import 'package:hiimimi/app/modules/home/controllers/home_controller.dart';
import 'package:hiimimi/app/modules/home/views/home_view.dart';
import 'package:hiimimi/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  // final userDataa = Get.find<HomeController>();

  RxInt pageIndex = 0.obs;

  void changePage(int i) async {
    print(i);
    switch (i) {
      case 1:
        pageIndex.value = i;
        Get.offAllNamed(Routes.INPUT_PAGE);
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.ALL_USERS);
        break;
      case 3:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE_PAGE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }
}
