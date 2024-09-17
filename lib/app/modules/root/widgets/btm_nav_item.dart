import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../models/menue.dart';

class BtmNavItem extends StatelessWidget {
  const BtmNavItem(
      {required this.navBar,
        required this.press,
        required this.riveOnInit,
        required this.selectedNav});

  final Menu navBar;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedNav;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 27,
            width: 27,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.rive.src,
                artboard: navBar.rive.artboard,
                onInit: riveOnInit,
              ),
            ),
          ),
          Opacity(
              opacity: selectedNav == navBar ? 1 : 0.6,
              child: Text(
                "${navBar.title.tr}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }
}
