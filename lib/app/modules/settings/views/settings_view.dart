import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/common/helper.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    controller.intiallPageController();
    final TapBarController = Get.put(TabBarController(), tag: tag);
    return WillPopScope(
        onWillPop: Helper().onWillpop,
        child: GetBuilder<SettingsController>(
          builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                  title: Text(
                    "Settings".tr,
                    style: context.textTheme.headline6,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios,
                        color: Get.theme.hintColor),
                    onPressed: () => Get.offNamed(Routes.ROOT),
                  ),
                  elevation: 0,
                  bottom: TabBarWidget(
                    initialSelectedId: controller.idChipWidget[0],
                    tag: 'settings',
                    tabs: [
                      Container(
                        width: Get.height/1.6,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return RawChip(
                              elevation: 0,
                              label: Text(controller.titleChip[index].tr),
                              labelStyle: TapBarController.isSelected(
                                  controller.idChipWidget[index])
                                  ? Get.textTheme.bodyText2?.merge(
                                  TextStyle(color: Get.theme.primaryColor))
                                  : Get.textTheme.bodyText2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              backgroundColor:
                              Get.theme.focusColor.withOpacity(0.1),
                              selectedColor: Get.theme.colorScheme.secondary,
                              selected: TapBarController.isSelected(controller.idChipWidget[index]),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              showCheckmark: false,
                              pressElevation: 0,
                              onSelected: (bool value) {
                                TapBarController.toggleSelected(
                                    controller.idChipWidget[index]);
                                controller.changePage(index);
                                controller.pageController.animateToPage(
                                    controller.currentIndex.value,
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.easeInOut);
                              },
                            ).marginSymmetric(horizontal: 5);
                          },
                          itemCount: controller.pages1.length,
                        ),
                      ),
                    ],
                  )),
              body: PageView.builder(
                controller: controller.pageController,
                itemBuilder: (context, index) {
                  return controller.pages1[index];
                },
                itemCount: controller.pages1.length,
                onPageChanged: (int index) {
                  controller.changePage(index);
                  TapBarController.toggleSelected(index);
                },
              ),
//        body: WillPopScope(
//          onWillPop: () async {
//            if (_navigatorKey!.currentState!.canPop()) {
//              _navigatorKey!.currentState!.pop();
//              return false;
//            }
//            return true;
//          },
//          child: Navigator(
//            key: _navigatorKey,
//            initialRoute: Routes.SETTINGS_LANGUAGE,
//            onGenerateRoute: controller.onGenerateRoute,
//          ),
//
//      ),
            );
          },
        ));
  }
}





//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:home_services/app/services/auth_service.dart';
//
//import '../../../routes/app_routes.dart';
//import '../../global_widgets/tab_bar_widget.dart';
//import '../controllers/settings_controller.dart';
//
//class SettingsView extends GetView<SettingsController> {
//  final _navigatorKey = Get.nestedKey(1);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//          title: Text(
//            "Settings".tr,
//            style: context.textTheme.headline6,
//          ),
//          centerTitle: true,
//          backgroundColor: Colors.transparent,
//          automaticallyImplyLeading: false,
//          leading: new IconButton(
//            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
//            onPressed: () => Get.back(),
//          ),
//          elevation: 0,
//          bottom: TabBarWidget(
//            initialSelectedId: 0,
//            tag: 'settings',
//            tabs: [
//              ChipWidget(
//                tag: 'settings',
//                text: "Languages".tr,
//                id: 0,
//                onSelected: (id) {
//                  controller.changePage(id);
//                },
//              ),
//              if(Get.find<AuthService>().isAuth)
//              ChipWidget(
//                tag: 'settings',
//                text: "Profile".tr,
//                id: 1,
//                onSelected: (id) {
//                  controller.changePage(id);
//                },
//              ),
//              if(Get.find<AuthService>().isAuth)
//              ChipWidget(
//                tag: 'settings',
//                text: "Addresses".tr,
//                id: 2,
//                onSelected: (id) {
//                  controller.changePage(id);
//                },
//              ),
//              ChipWidget(
//                tag: 'settings',
//                text: "Theme Mode".tr,
//                id: 3,
//                onSelected: (id) {
//                  controller.changePage(id);
//                },
//              )
//            ],
//          )),
//      body: WillPopScope(
//        onWillPop: () async {
//          if (_navigatorKey!.currentState!.canPop()) {
//            _navigatorKey!.currentState!.pop();
//            return false;
//          }
//          return true;
//        },
//        child: Navigator(
//          key: _navigatorKey,
//          initialRoute: Routes.SETTINGS_LANGUAGE,
//          onGenerateRoute: controller.onGenerateRoute,
//        ),
//      ),
//    );
//  }
//}
