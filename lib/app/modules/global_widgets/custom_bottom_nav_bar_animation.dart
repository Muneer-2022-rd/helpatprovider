import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/models/menue.dart';
import 'package:home_services_provider/app/modules/root/widgets/btm_nav_item.dart';
import 'package:home_services_provider/common/class/rive_utils.dart';

import '../root/controllers/root_controller.dart';

class AnimationCustomNavigationBar extends StatefulWidget {
  @override
  _AnimationCustomNavigationBarState createState() =>
      _AnimationCustomNavigationBarState();
}

class _AnimationCustomNavigationBarState
    extends State<AnimationCustomNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    RootController controller = Get.find();

    controller.animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });

    controller.animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    Get.find<RootController>().animationController.dispose();
    Get.find<RootController>().animationController.addListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
      builder: (controller) {
        return Transform.translate(
          filterQuality: FilterQuality.high,
          offset: Offset(0, controller.animation.value * 100),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, right: 12, bottom: 12),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.secondary.withOpacity(.9),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    bottomNavItems.length,
                        (index) {
                      Menu navBar = bottomNavItems[index];
                      return BtmNavItem(
                        navBar: navBar,
                        press: () {
                          RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                          controller.changePageInRoot(index);
                        },
                        riveOnInit: (artboard) {
                          navBar.rive.status = RiveUtils.getRiveInput(
                              artboard,
                              stateMachineName: navBar.rive.stateMachineName);
                        },
                        selectedNav: controller.selectedBottonNav,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
