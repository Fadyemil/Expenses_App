import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expenses/widgets/auth/Logo.dart';
import 'package:expenses/widgets/auth/Text.dart';
import 'package:expenses/widgets/auth/custom_button.dart';
import 'package:expenses/widgets/auth/custom_textFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingUP extends StatefulWidget {
  const SingUP({super.key});

  @override
  State<SingUP> createState() => _SingUPState();
}

class _SingUPState extends State<SingUP> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  const CustomText(text: "SingUP"),
                  const SizedBox(height: 10),
                  const Text(
                    "Login To Continue Using The App",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  CustomText(text: "userName"),
                  CustomTextFiledFrom(
                    hintText: "Enter User Name",
                    MyController: username,
                    validate: (val) {
                      if (val == "") {
                        return "Can't To Be Empty";
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  const CustomText(text: "Email"),
                  const SizedBox(height: 12),
                  CustomTextFiledFrom(
                    hintText: "Enter Your Email",
                    MyController: email,
                    validate: (val) {
                      if (val == "") {
                        return "Can't To Be Emoty";
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
                  const SizedBox(height: 25),
                  const CustomText(text: " Confirm Password"),
                  CustomTextFiledFrom(
                    hintText: "Enter Confirm Password",
                    MyController: password,
                    validate: (val) {
                      if (val == "") {
                        return "Can't To Be Empty";
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: CustomButton(
                        title: 'Sing Up',
                        onPressed: () async {
                          if (formState.currentState()!.validate()) {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();
                              Navigator.of(context)
                                  .pushReplacementNamed("LoginPage");
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'The password provided is too weak.',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                ).show();
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc:
                                    'The account already exists for that email.',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                            } catch (e) {
                              print(e);
                            }
                          } else {
                            print("error in login form");
                          }
                        }),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("LoginPage");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "have An Account ?",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    " Login",
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
}
