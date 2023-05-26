import 'package:flutter/material.dart';
import 'package:keepnotes/home_page.dart';

import 'auth_class.dart';
import 'clipper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formField = GlobalKey<FormState>();
  bool passToggle = true;
  bool repeatpassToggle = true;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();
  void myalertdialog() {

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('back'))
            ],
            backgroundColor: Colors.grey,
            title: const Text('Check your credentials'),
          );
        });
  }
  Widget userNameTextField() {
    return TextFormField(
      controller: userNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your usernme';
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:const EdgeInsets.only(top: 14),
          prefixIcon: const Icon(Icons.supervised_user_circle_rounded),
          hintText: 'UserName'),
    );
  }
  Widget emailTextField() {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);
        if (value.isEmpty) {
          return 'Please enter email';
        } else if (!emailValid) {
          return ' Please enter valid email';
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.only(top: 14),
          prefixIcon: const Icon(Icons.email_rounded),
          hintText: 'Your Email'),
    );
  }
  Widget passwordTextField() {
    return TextFormField(
      controller: passwordController,
      obscureText: passToggle,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Password';
        } else if (passwordController.text.length < 6) {
          return 'Password length should be more than 6 characters';
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.only(top: 14),
          prefixIcon:const  Icon(Icons.lock_outlined),
          hintText: 'Your Password',
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                passToggle = !passToggle;
              });
            },
            child:
            Icon(passToggle ? Icons.visibility : Icons.visibility_off),
          )),
    );
  }
  Widget repeatPasswordTextField() {
    return TextFormField(
      obscureText: repeatpassToggle,
      controller: repeatpasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Password';
        } else if (repeatpasswordController.text.length < 6) {
          return 'Password should be more than 6 characters';
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:const  EdgeInsets.only(top: 14),
          prefixIcon: const Icon(Icons.lock_outlined),
          hintText: 'Repeat Password',
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                repeatpassToggle = !repeatpassToggle;
              });
            },
            child: Icon(
                repeatpassToggle ? Icons.visibility : Icons.visibility_off),
          )),
    );
  }




  @override
  Widget build(BuildContext context) {
    //this is height = 10
    final height = MediaQuery.of(context).size.height/80;
    final width = MediaQuery.of(context).size.width/2.3;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentNode = FocusScope.of(context);
        if (currentNode.focusedChild != null && !currentNode.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, height *30),
                    painter: RPSCustomPainter(),
                  ),
                  Positioned(
                      top: 16,
                      right: -5,
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width,height *30),
                        painter: RPSCustomPainter1(),
                      )),
                  const Positioned(
                      top: 170,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Account',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 26),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Just a quick signup',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20),
                          ),
                        ],
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 25,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                    right: 25,
                    top: 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: height,
                        ),
                        userNameTextField(),
                        SizedBox(
                          height: height,
                        ),
                        emailTextField(),
                        SizedBox(
                          height: height,
                        ),
                        passwordTextField(),
                        SizedBox(
                          height: height,
                        ),
                        repeatPasswordTextField(),
                        SizedBox(
                          height: height+3,
                        ),
                        Container(
                          height: height*5,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xfff7b858),
                                Color(0xfffca148),
                              ],
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              //  String displayname = await firebaseAuth.updateDisplayName(userNameController.text).toString();
                              if (formField.currentState!.validate() &&
                                  (passwordController.text ==
                                      repeatpasswordController.text)) {
                                //sign up with firebase
                                Auth().createFirebaseAccount(
                                    emailController.text,
                                    passwordController.text);

                                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                              } else {
                                myalertdialog();
                              }
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width/5,
                                ),
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                 SizedBox(
                                  width: width/7,
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height*15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sign up using Google?',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            SizedBox(width: height,),
                            InkWell(
                              onTap: (){
                                Auth().signInWithGoogle();
                              },
                              child:  const Text(
                                'Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xfffca148),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
