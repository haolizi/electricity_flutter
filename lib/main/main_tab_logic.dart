import 'package:get/get.dart';

class MainTabLogic extends GetxController {
  MainState state = MainState();

  changeBottomBarIndex(int index) {
    state.bottomIndex.value = index;
  }
}

class MainState {
  RxInt bottomIndex = 0.obs;
}