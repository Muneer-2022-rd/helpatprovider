import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/root/controllers/root_controller.dart';
import 'package:home_services_provider/common/helper.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../../../common/ui.dart';
import '../../../models/media_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/phone_verification_bottom_sheet_widget.dart';

class ProfileController extends GetxController {
  final loading = false.obs;
  Rx<User> user = new User().obs;
  Rx<Media> avatar = new Media().obs;
  final hidePassword = true.obs;
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final confirmPassword = "".obs;
  final smsSent = "".obs;
  GlobalKey<FormState>? profileForm;
  late UserRepository _userRepository;

  ProfileController() {
    _userRepository = new UserRepository();
  }

  @override
  void onInit() {
    user.value = Get.find<AuthService>().user.value;
    avatar.value = new Media(thumb: user.value.avatar!.thumb);
    super.onInit();
  }

  Future refreshProfile({bool? showMessage}) async {
    await getUser();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of faqs refreshed successfully".tr));
    }
  }

  void saveProfileForm() async {
    Get.focusScope!.unfocus();
    if (profileForm!.currentState!.validate()) {
      try {
        profileForm!.currentState!.save();
        user.value.deviceToken = null;
        print("old password filed: ${oldPassword.value}");
        print("old password : ${user.value.password}");
        user.value.password = (newPassword.value == confirmPassword.value) &&
                (newPassword.value.isNotEmpty &&
                    confirmPassword.value.isNotEmpty)
            ? newPassword.value
            : user.value.password;
        print("Password: ${user.value.password}");
        user.value.avatar = avatar.value;
        Get.find<AuthService>().user.value =
            await _userRepository.update(user.value);
        Get.offNamedUntil(Routes.ROOT, (route) => false);
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "Update Profile Successfully"));
//        await _userRepository.sendCodeToPhone();
//        Get.bottomSheet(
//            PhoneVerificationBottomSheetWidget(),
//            isScrollControlled: false);
//        );
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {}
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
  }

  Future<void> verifyPhone() async {
    try {
      await _userRepository.verifyPhone(smsSent.value);
      Get.find<AuthService>().user.value =
          await _userRepository.update(user.value);
      Get.back();
      Get.offNamedUntil(Routes.ROOT, (route) => false);
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Update Profile Successfully"));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString().substring(11)));
    }
  }

  void resetProfileForm() {
    avatar.value = new Media(thumb: user.value.avatar!.thumb);
    profileForm!.currentState!.reset();
  }

  Future getUser() async {
    try {
      user.value = await _userRepository.getCurrentUser();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  openSweetSheet(BuildContext context) {
    Dialogs.bottomMaterialDialog(
        msg: 'Are you sure you want to delete your account ?'.tr,
        title: 'Delete'.tr,
        context: context,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Get.back();
            },
            text: 'Cancel'.tr,
            iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: () async {
              Get.back();
              await deleteProfile();
            },
            text: 'Delete'.tr,
            iconData: Icons.delete,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
  Future<void> deleteProfile() async {
    try {
      loading.value = true;
      update();
      _userRepository.delete(user.value).then((value) async {
        Get.find<AuthService>().removeCurrentUser().then((value) async {
          await Helper().onWillpop();
          loading.value = false;
          update();
          Get.showSnackbar(
              Ui.SuccessSnackBar(message: "Profile Deleted successfully".tr));
        });

          Future.delayed(Duration(seconds: 2), () {
            Get.find<RootController>().changePage(0);
          });
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
