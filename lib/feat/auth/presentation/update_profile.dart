import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/di/di.dart';
import 'package:movies_flutter/feat/auth/data/repos/auth_repo.dart';
import 'package:movies_flutter/feat/auth/presentation/forget_password.dart';
import 'package:movies_flutter/feat/auth/presentation/login.dart';
import 'package:movies_flutter/feat/auth/presentation/register.dart';
import 'package:movies_flutter/generated/l10n.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  String selectedAvatar = 'assets/avatar1.png';
  final List<String> avatars = [
    'assets/avatar1.png',
    'assets/avatar2.png',
    'assets/avatar3.png',
    'assets/avatar4.png',
    'assets/avatar5.png',
    'assets/avatar6.png',
    'assets/avatar7.png',
    'assets/avatar8.png',
    'assets/avatar9.png',
  ];

  User? user;
  bool loading = false;
  final AuthRepo repo = sl();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    setState(() {
      loading = true;
    });
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .get();
      if (userDoc.exists) {
        setState(() {
          nameController.text = userDoc['name'] ?? '';
          phoneController.text = userDoc['phone'] ?? '';
          selectedAvatar = userDoc['photo'] ?? 'assets/avatar1.png';
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _updateUserData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        // await user!.updateDisplayName(nameController.text);
        // await user!.updatePhotoURL(selectedAvatar);
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(user!.uid)
        //     .update({
        //       'name': nameController.text,
        //       'phone': phoneController.text,
        //       'photo': selectedAvatar,
        //     });
        final state = await repo.updateAccount(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          avataId: avatars.indexOf(selectedAvatar),
        );
        if (state.data != null && state.data == true && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update profile')));
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => AlertDialog(
                backgroundColor: Color(0xff282A28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text(
                  "Are you sure?",
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  "This action cannot be undone.",
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Color(0xffF6BD00)),
                    ),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Future<void> _deleteAccount() async {
    if (await _showDeleteConfirmationDialog()) {
      setState(() {
        loading = true;
      });
      try {
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(user!.uid)
        //     .delete();
        // await user!.delete();
        final deletedState = (await repo.deleteAccount());
        if (deletedState.data == true && (mounted)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete account')));
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatars[index];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color:
                        selectedAvatar == avatars[index]
                            ? Colors.yellow
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.yellow),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatars[index]),
                    radius: 40,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xffF6BD00)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).pick_avatar,
          style: TextStyle(color: ColorsApp.yellow),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child:
            loading
                ? Center(child: CircularProgressIndicator())
                : Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                          onTap: _showAvatarPicker,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(selectedAvatar),
                            radius: 60,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff282A28),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(Icons.person),
                          hintText: S.of(context).name,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff282A28),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                          hintText: S.of(context).phone_number,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff282A28),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(Icons.person),
                          hintText: S.of(context).email,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPassword(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(S.of(context).reset_password),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      FilledButton(
                        onPressed: _deleteAccount,
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xffE82626),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                        child: Text(
                          S.of(context).delete_account,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: _updateUserData,
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xffF6BD00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                        child: Text(
                          S.of(context).update_data,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
      ),
    );
  }
}
