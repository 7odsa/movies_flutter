import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter/feat/auth/presentation/check_email.dart';
import 'package:movies_flutter/feat/auth/presentation/login.dart';
import 'package:movies_flutter/feat/auth/presentation/widgets/show_flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool loading = false;
  bool passwordObscured = true;
  bool confirmPasswordObscured = true;
  bool isArabic = false;

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

  int selectedIndex = 0;

  Future signUp() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        showError("Passwords do not match", context);
        return;
      }

      setState(() {
        loading = true;
      });

      try {
        final signInMethods = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(emailController.text);
        if (signInMethods.isNotEmpty) {
          setState(() {
            loading = false;
          });
          showError("This email is already in use", context);
          return;
        }

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        await userCredential.user!.updateDisplayName(nameController.text);
        await userCredential.user!.updatePhotoURL(avatars[selectedIndex]);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
              "name": nameController.text,
              "email": emailController.text,
              "phone": phoneController.text,
              "photo": avatars[selectedIndex],
              "uid": FirebaseAuth.instance.currentUser!.uid,
            });

        setState(() {
          loading = false;
        });
        showSuccess("Successfully Registered", context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
        setState(() {
          loading = false;
        });
        showError(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                    'Register',
                    style: TextStyle(
                      color: Color(0xffF6BD00),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(
                height: 150,
                child: CarouselSlider.builder(
                  itemCount: avatars.length,
                  itemBuilder: (context, index, realIndex) {
                    bool isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: itemWidth,
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(avatars[index]),
                          radius: isSelected ? 50 : 40,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 150,
                    viewportFraction: 0.33,
                    enlargeCenterPage: true,
                    initialPage: selectedIndex,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your email";
                  } else if (value.isValidEmail == false) {
                    return "Invalid email";
                  }
                  return null;
                },
                autofillHints: const [
                  AutofillHints.email,
                  AutofillHints.password,
                ],
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff282A28),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: passwordObscured,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff282A28),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordObscured = !passwordObscured;
                      });
                    },
                    icon:
                        passwordObscured
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                  ),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: confirmPasswordObscured,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please confirm your password";
                  } else if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff282A28),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        confirmPasswordObscured = !confirmPasswordObscured;
                      });
                    },
                    icon:
                        confirmPasswordObscured
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                  ),
                  hintText: 'Confirm Password',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                    return "Invalid phone number (11 digits required)";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
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
              FilledButton(
                onPressed: loading ? null : signUp,
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xffF6BD00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  padding: EdgeInsets.all(15),
                ),
                child:
                    loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Create Account',
                          style: TextStyle(fontSize: 20),
                        ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have Account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xffF6BD00),
                    ),
                    child: Text('Login', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 137),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xffF6BD00)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:
                          () => setState(() {
                            isArabic = false;
                          }),
                      child: CircleAvatar(
                        backgroundColor:
                            !isArabic ? Color(0xffF6BD00) : Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/USA.png'),
                          radius: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          () => setState(() {
                            isArabic = true;
                          }),
                      child: CircleAvatar(
                        backgroundColor:
                            isArabic ? Color(0xffF6BD00) : Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/EG.png'),
                          radius: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
