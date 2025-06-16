import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/feat/profile/presentation/providers/profile_provider.dart';
import 'package:movies_flutter/feat/profile/presentation/widgets/custom_elevated_buttom.dart';
import 'package:movies_flutter/feat/profile/presentation/widgets/custom_text_filed.dart';
import 'package:provider/provider.dart';
import 'package:movies_flutter/feat/profile/presentation/screens/avater_selector.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    nameController = TextEditingController(text: profileProvider.userName);
    phoneController = TextEditingController(text: profileProvider.phoneNumber);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _showAvatarSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsApp.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AvatarSelector(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.black,
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: TextStyle(
            color: ColorsApp.yellow,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsApp.yellow),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Center(child: buildAvatar()),
              SizedBox(height: 35),
              buildNameTextField(),
              SizedBox(height: 16),
              buildPhoneNumberTextField(),
              SizedBox(height: 30),
              buildResetPassword(),
              SizedBox(height: 120),
              buildDeleteAccountElevatedButton(),
              SizedBox(height: 16),
              buildUpdateDataElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAvatar() => Consumer<ProfileProvider>(
    builder:
        (context, provider, child) => GestureDetector(
          onTap: _showAvatarSelector,
          child: CircleAvatar(
            radius: 75,
            backgroundColor: ColorsApp.gray,
            child: Image.asset(provider.selectedAvatar),
          ),
        ),
  );

  Widget buildNameTextField() => CustomTexFiled(
    prefixIcon: Icon(Icons.person, color: ColorsApp.white),
    controller: nameController,
    hintText: 'Enter name here',
  );

  Widget buildPhoneNumberTextField() => CustomTexFiled(
    prefixIcon: Icon(Icons.phone, color: Colors.white),
    controller: phoneController,
    hintText: 'Enter phone number',
  );

  Widget buildResetPassword() => InkWell(
    onTap: () {},
    child: Text(
      'Reset Password',
      style: AppStyle.textTheme.displayMedium,
      textAlign: TextAlign.start,
    ),
  );

  Widget buildDeleteAccountElevatedButton() => CustomElevatedButton(
    onClick: () {},
    text: 'Delete Account',
    textStyle: TextStyle(
      color: ColorsApp.white,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    horizontal: 60,
    vertical: 15,
    backgroundColor: ColorsApp.red,
  );

  Widget buildUpdateDataElevatedButton() => CustomElevatedButton(
    onClick: () {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      profileProvider.updateProfile(
        name: nameController.text,
        phone: phoneController.text,
      );
      Navigator.pop(context);
    },
    text: 'Update Data',
    textStyle: TextStyle(
      color: ColorsApp.white,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    horizontal: 70,
    vertical: 15,
    backgroundColor: ColorsApp.yellow,
  );
}
