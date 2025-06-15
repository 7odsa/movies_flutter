import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/feat/profile/presentation/widgets/custom_elevated_buttom.dart';
import 'package:movies_flutter/feat/profile/presentation/widgets/custom_text_filed.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController nameController = TextEditingController(
    text: 'John Safwat',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '01200000000',
  );

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
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
            children: [
              SizedBox(height: 16),
              buildAvatar(),
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

  ///todo: update avatar
  Widget buildAvatar() =>
      CircleAvatar(radius: 75, child: Image.asset('assets/gamer (1).png'));

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
      Navigator.pop(context, nameController.text);
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
