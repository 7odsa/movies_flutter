import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _userName = 'John Safwat';
  String _phoneNumber = '01200000000';
  String _selectedAvatar = 'assets/profile1.png';


  String get userName => _userName;
  String get phoneNumber => _phoneNumber;
  String get selectedAvatar => _selectedAvatar;

  final List<String> availableAvatars = List.generate(
    9,
    (index) => 'assets/profile${index + 1}.png',
  );

  void updateProfile({String? name, String? phone, String? avatar}) {
    if (name != null) _userName = name;
    if (phone != null) _phoneNumber = phone;
    if (avatar != null) _selectedAvatar = avatar;
    notifyListeners();
  }
} 