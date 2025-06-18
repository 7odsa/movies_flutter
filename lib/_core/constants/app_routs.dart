import 'package:flutter/material.dart';
import 'package:movies_flutter/feat/profile/presentation/screens/profile_tap.dart';
import 'package:movies_flutter/feat/profile/presentation/screens/update_profile.dart';

abstract final class AppRouts {
  static Route updateProfile() =>
      MaterialPageRoute(builder: (_) => UpdateProfile());
}
