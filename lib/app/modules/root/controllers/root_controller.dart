/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../models/custom_page_model.dart';
import '../../../models/menue.dart';
import '../../../repositories/custom_page_repository.dart';
import '../../../repositories/notification_repository.dart';
import '../../../routes/app_routes.dart';
import '../../account/views/account_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';
import '../../messages/controllers/messages_controller.dart';
import '../../messages/views/messages_view.dart';
import '../../reviews/views/reviews_view.dart';

class RootController extends GetxController {
  final currentIndex = 0.obs;
  final notificationsCount = 0.obs;
  final RxList<CustomPage> customPages = <CustomPage>[].obs;
  late NotificationRepository _notificationRepository;
  late CustomPageRepository _customPageRepository;

  bool hideNavigationBar = false;

  late AnimationController animationController;

  late Animation<double> animation;

  Menu selectedBottonNav = bottomNavItems.first;
  late SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu, int index) {
    if (Get.find<RootController>().selectedBottonNav != menu) {
      currentIndex.value = index;
      Get.find<RootController>().selectedBottonNav = menu;
      update();
    }
  }

  RootController() {
    _notificationRepository = new NotificationRepository();
    _customPageRepository = new CustomPageRepository();
  }

  @override
  void onInit() async {
    await getCustomPages();
    if (Get.arguments != null && Get.arguments is int) {
      changePageInRoot(Get.arguments as int);
    } else {
      changePageInRoot(0);
    }
    super.onInit();
  }

  List<Widget> pages = [
    HomeView(),
    ReviewsView(),
    MessagesView(),
    AccountView(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  /**
   * change page in route
   * */
  void changePageInRoot(int _index) async {
    currentIndex.value = _index;
    updateSelectedBtmNav(bottomNavItems[_index], _index);
    update();
    await refreshPage(_index);
  }

  void changePageOutRoot(int _index) {
    currentIndex.value = _index;
    Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  Future<void> changePage(int _index) async {
    if (Get.currentRoute == Routes.ROOT) {
      changePageInRoot(_index);
    } else {
      changePageOutRoot(_index);
    }
    await refreshPage(_index);
  }

  Future<void> refreshPage(int _index) async {
    switch (_index) {
      case 0:
        {
          await Get.find<HomeController>().refreshHome();
          break;
        }
      case 2:
        {
          await Get.find<MessagesController>().refreshMessages();
          break;
        }
    }
  }

  void getNotificationsCount() async {
    notificationsCount.value = await _notificationRepository.getCount();
  }

  Future<void> getCustomPages() async {
    customPages.assignAll(await _customPageRepository.all());
  }
}
