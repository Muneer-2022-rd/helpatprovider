import 'package:flutter/cupertino.dart';
import 'rive_model.dart';

class Menu {
  final int index;

  final String title;
  final RiveModel rive;

  Menu({required this.index, required this.title, required this.rive});
}

//List<Menu> sidebarMenus = [
//  Menu(
//    index: 0,
//    title: "Home",
//    rive: RiveModel(
//        src: "assets/RiveAssets/icons.riv",
//        artboard: "HOME",
//        stateMachineName: "HOME_interactivity"),
//  ),
//  Menu(
//    index: 1,
//    title: "Search",
//    rive: RiveModel(
//        src: "assets/RiveAssets/icons.riv",
//        artboard: "SEARCH",
//        stateMachineName: "SEARCH_Interactivity"),
//  ),
//  Menu(
//    index: 2,
//    title: "Favorites",
//    rive: RiveModel(
//        src: "assets/RiveAssets/icons.riv",
//        artboard: "LIKE/STAR",
//        stateMachineName: "STAR_Interactivity"),
//  ),
//  Menu(
//    in
//    title: "Help",
//    rive: RiveModel(
//        src: "assets/RiveAssets/icons.riv",
//        artboard: "CHAT",
//        stateMachineName: "CHAT_Interactivity"),
//  ),
//];
//List<Menu> sidebarMenus2 = [
//  Menu(
//    title: "History",
//    rive: RiveModel(
//        src: "assets/RiveAssets/icons.riv",
//        artboard: "TIMER",
//        stateMachineName: "TIMER_Interactivity"),
//  ),
//  Menu(
//    title: "Notifications",
//    rive: RiveModel(
//        src: "assets/RiveAssets/icons.riv",
//        artboard: "BELL",
//        stateMachineName: "BELL_Interactivity"),
//  ),
//];

List<Menu> bottomNavItems = [
  Menu(
    index: 0,
    title: "Home",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  Menu(
    index: 1,
    title: "Reviews",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "LIKE/STAR",
        stateMachineName: "STAR_Interactivity"),
  ),
  Menu(
    index: 2,
    title: "Chat",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
  ),
  Menu(
    index: 3,
    title: "Account",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ),
];
