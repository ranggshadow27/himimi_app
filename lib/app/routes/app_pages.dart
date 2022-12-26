import 'package:get/get.dart';

import 'package:hiimimi/app/modules/all_details/bindings/all_details_binding.dart';
import 'package:hiimimi/app/modules/all_details/views/all_details_view.dart';
import 'package:hiimimi/app/modules/all_users/bindings/all_users_binding.dart';
import 'package:hiimimi/app/modules/all_users/views/all_users_view.dart';
import 'package:hiimimi/app/modules/details/bindings/details_binding.dart';
import 'package:hiimimi/app/modules/details/views/details_view.dart';
import 'package:hiimimi/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:hiimimi/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:hiimimi/app/modules/home/bindings/home_binding.dart';
import 'package:hiimimi/app/modules/home/views/home_view.dart';
import 'package:hiimimi/app/modules/input_page/bindings/input_page_binding.dart';
import 'package:hiimimi/app/modules/input_page/views/input_page_view.dart';
import 'package:hiimimi/app/modules/login/bindings/login_binding.dart';
import 'package:hiimimi/app/modules/login/views/login_view.dart';
import 'package:hiimimi/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:hiimimi/app/modules/new_password/views/new_password_view.dart';
import 'package:hiimimi/app/modules/profile_page/bindings/profile_page_binding.dart';
import 'package:hiimimi/app/modules/profile_page/views/profile_page_view.dart';
import 'package:hiimimi/app/modules/register_user/bindings/register_user_binding.dart';
import 'package:hiimimi/app/modules/register_user/views/register_user_view.dart';
import 'package:hiimimi/app/modules/update_password/bindings/update_password_binding.dart';
import 'package:hiimimi/app/modules/update_password/views/update_password_view.dart';
import 'package:hiimimi/app/modules/update_profile/bindings/update_profile_binding.dart';
import 'package:hiimimi/app/modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTER_USER,
      page: () => RegisterUserView(),
      binding: RegisterUserBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS,
      page: () => DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.ALL_DETAILS,
      page: () => AllDetailsView(),
      binding: AllDetailsBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_PAGE,
      page: () => InputPageView(),
      transition: Transition.fadeIn,
      binding: InputPageBinding(),
    ),
    GetPage(
      name: _Paths.ALL_USERS,
      page: () => AllUsersView(),
      binding: AllUsersBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
