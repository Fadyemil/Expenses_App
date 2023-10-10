import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expenses/widgets/auth/Logo.dart';
import 'package:expenses/widgets/auth/Text.dart';
import 'package:expenses/widgets/auth/custom_button.dart';
import 'package:expenses/widgets/auth/custom_textFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const CustomLogo(
                            image:
                                'assets/finance-department-employees-are-calculating-expenses-company-s-business_1150-41782.jpg'),
                        const SizedBox(height: 20),
                        const CustomText(text: "LOGIN"),
                        const SizedBox(height: 10),
                        const Text(
                          "Login To Continue Using The App",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 25),
                        const CustomText(text: "Email"),
                        const SizedBox(height: 12),
                        CustomTextFiledFrom(
                          hintText: "Enter Your Email",
                          MyController: email,
                          validate: (val) {
                            if (val == "") {
                              return "Can't To Be Empty";
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        const CustomText(text: "Password"),
                        const SizedBox(height: 12),
                        CustomTextFiledFrom(
                          hintText: "Enter Your Password",
                          MyController: password,
                          validate: (val) {
                            if (val == "") {
                              return "Can't To Be Empty";
                            }
                          },
                        ),
                        InkWell(
                          onTap: () async {
                            try {
                              await sendPassResetEmil(context);
                            } catch (e) {
                              ifEmailEqualNull(e, context);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            alignment: Alignment.topRight,
                            child: const Text(
                              "Forgot Password ?",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 45,
                          child: CustomButton(
                            title: 'LOGIN',
                            onPressed: () async {
                              if (formState.currentState()!.validate()) {
                                try {
                                  await trueLogin(context);
                                } on FirebaseAuthException catch (e) {
                                  FalseLogin(context);
                                }
                              } else {
                                print("error in login form");
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("singup");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Dont't have An Account ?",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          " Register",
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void FalseLogin(BuildContext context) {
    isLoading = false;
    setState(() {});
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Dialog Title',
      desc: 'الايمل او كلمة المرور غلط',
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> trueLogin(BuildContext context) async {
    isLoading = true;
    setState(() {});
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
    isLoading = false;
    setState(() {});
    if (credential.user!.emailVerified) {
      Navigator.of(context).pushReplacementNamed("expanses");
    } else {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      print("Error");
    }
  }

  void ifEmailEqualNull(Object e, BuildContext context) {
    print(e);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: 'برجاء ادخال البريد الاكتروني',
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> sendPassResetEmil(BuildContext context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Dialog Title',
      desc: 'تم ارسال رساله لي البريد الاكتروني',
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
}
