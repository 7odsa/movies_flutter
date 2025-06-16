import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter/feat/auth/presentation/forget_password.dart';
import 'package:movies_flutter/feat/auth/presentation/login.dart';
import 'package:movies_flutter/feat/auth/presentation/register.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
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
        await user!.updateDisplayName(nameController.text);
        await user!.updatePhotoURL(selectedAvatar);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'name': nameController.text,
          'phone': phoneController.text,
          'photo': selectedAvatar,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
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
      builder: (context) => AlertDialog(
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
            child: Text("Delete", style: TextStyle(color: Color(0xffF6BD00))),
          ),
        ],
      ),
    ) ?? false;
  }

  Future<void> _deleteAccount() async {
    if (await _showDeleteConfirmationDialog()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .delete();
        await user!.delete();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete account')),
        );
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
                    color: selectedAvatar == avatars[index]
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
      body: SafeArea(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xffF6BD00)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                  Text(
                    'Pick Avatar',
                    style: TextStyle(
                      color: Color(0xffF6BD00),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
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
                  hintText: 'Name',
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
                  hintText: 'Phone',
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
                          builder: (context) => ForgetPassword()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Reset Password'),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .30),
              FilledButton(
                onPressed: _deleteAccount,
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xffE82626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side:
                    BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  padding: EdgeInsets.all(15),
                ),
                child: Text(
                  'Delete Account',
                  style:
                  TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _updateUserData,
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xffF6BD00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side:
                    BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  padding: EdgeInsets.all(15),
                ),
                child: Text('Update Data', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}