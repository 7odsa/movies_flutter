import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_flutter/_resources/common_state_holders/l10n_sh/cubit/l10n_cubit.dart';
import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/_resources/helpers/shared_prefs.dart';
import 'package:movies_flutter/feat/auth/data/data_sources/auth_remote_ds.dart';
import 'package:movies_flutter/feat/auth/data/repos/auth_repo.dart';
import 'package:movies_flutter/feat/auth/presentation/check_email.dart';
import 'package:movies_flutter/feat/auth/presentation/forget_password.dart';
import 'package:movies_flutter/feat/auth/presentation/register.dart';
import 'package:movies_flutter/feat/auth/presentation/widgets/show_flushbar.dart';
import 'package:movies_flutter/feat/nav_screen.dart';
import 'package:movies_flutter/generated/l10n.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool loading = false;
  bool passwordObscured = true;
  bool isArabic = false;

  final AuthRepo authRepo = AuthRepo(authRemoteDS: AuthRemoteDS());

  Future signIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        // await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: emailController.text,
        //   password: passwordController.text,
        // );
        final tokenState = await authRepo.login(
          emailController.text,
          passwordController.text,
        );
        setState(() {
          loading = false;
        });
        if (mounted) {
          if (tokenState is DataSuccess) {
            print(
              tokenState.data ??
                  '**************************************    No token',
            );
            SharedPrefs.setUserToken(tokenState.data ?? '');
            showSuccess("Successfully Logged In", context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NavScreen()),
            );
          } else {
            showError(tokenState.errorMsg ?? 'err', context);
          }
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        if (mounted) {
          showError(e.toString(), context);
        }
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      showSuccess("Successfully Logged In with Google", context);
    } catch (e) {
      showError(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Image.asset("assets/login_image.png", height: 300),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your email";
                  } else if (value.isValidEmail == false) {
                    return "Invalid email";
                  }
                  return null;
                },
                autofillHints: const [AutofillHints.email],
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
                  hintText: S.of(context).email,
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
                  hintText: S.of(context).password,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      '${S.of(context).forget_password} ?',
                      style: TextStyle(color: Color(0xffF6BD00), fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: loading ? null : signIn,
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
                        : Text(
                          S.of(context).login,
                          style: TextStyle(fontSize: 20),
                        ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).dont_have_account),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xffF6BD00),
                    ),
                    child: Text(
                      S.of(context).create_account,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xffF6BD00))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        S.of(context).or,
                        style: TextStyle(
                          color: Color(0xffF6BD00),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: Color(0xffF6BD00))),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: signInWithGoogle,
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xffF6BD00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  padding: EdgeInsets.all(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(AssetImage('assets/🦆 icon _google_.png')),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).login_with_google,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
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
                  spacing: 15,
                  children: [
                    GestureDetector(
                      onTap:
                          () => setState(() {
                            context.read<L10nCubit>().switchLanguage(
                              EnumLang.en,
                            );
                            isArabic = false;
                          }),
                      child: CircleAvatar(
                        backgroundColor:
                            isArabic ? Color(0xffF6BD00) : Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/USA.png'),
                          radius: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          () => setState(() {
                            context.read<L10nCubit>().switchLanguage(
                              EnumLang.ar,
                            );
                            isArabic = true;
                          }),
                      child: CircleAvatar(
                        backgroundColor:
                            !isArabic ? Color(0xffF6BD00) : Colors.transparent,
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
