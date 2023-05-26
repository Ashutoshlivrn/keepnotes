import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keepnotes/home_page.dart';
import 'package:keepnotes/sign_up_page.dart';
import 'auth_class.dart';
import 'clipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formField = GlobalKey<FormState>();
  bool passToggle = true;
  var email = TextEditingController();
  var password = TextEditingController();
  Widget emailTextField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);
        if (value.isEmpty) {
          return 'Please enter email';
        } else if (!emailValid) {
          return ' Please enter valid email  ....@gmail.com';
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.only(top: 14),
          prefixIcon:  const Icon(Icons.email),
          hintText: 'Your Email'),
    );
  }
  Widget passwordTextField() {
    return TextFormField(
      obscureText: passToggle,
      controller: password,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your Password';
        } else if (password.text.length < 6) {
          return 'Set a strong password';
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.only(top: 14),
          prefixIcon: const Icon(Icons.lock_outlined),
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

  @override
  Widget build(BuildContext context) {
    // this height is height=10
    final height = MediaQuery.of(context).size.height/80;


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
            children: [
              Stack(
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, height*30),
                    painter: RPSCustomPainter(),
                  ),
                  Positioned(
                      top: 16,
                      right: -5,
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, height*30),
                        painter: RPSCustomPainter1(),
                      )),
                   Positioned(
                      top: height*20,
                      left: height*2.8,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 26),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Please SignIn to continue',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20),
                          ),
                        ],
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: height*3,
                  right: height*3,
                  bottom: MediaQuery.of(context).viewInsets.bottom + height*2,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: height*1.4,
                        ),
                        emailTextField(),
                        SizedBox(
                          height: height*1.3,
                        ),
                        passwordTextField(),
                        SizedBox(
                          height: height*1.4,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formField.currentState!.validate()) {
                              try {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        elevation: 13,
                                        content: Text('signing in')));
                                await Auth().signInWithFirebase(
                                    email.text, password.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        elevation: 13,
                                        content: Text('signed in')));
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.grey,
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child:const Text('back'))
                                      ],
                                      title: const Text(
                                          'No user found for that email'),
                                    ),
                                  );
                                } else if (e.code == 'wrong-password') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.grey,
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('back'))
                                      ],
                                      title: const Text(
                                          'Wrong password provided for this user'),
                                    ),
                                  );
                                }
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.grey,
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('back'))
                                  ],
                                  title: const Text(
                                      ' Please check your credentials '),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: height*5,
                            width: height*14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xfff7b858),
                                  Color(0xfffca148),
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: height*2,
                                ),
                                const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: height*4,
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
                          height: height*20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await Auth().signInWithGoogle();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('logged in')));
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        elevation: 13,
                                        content: Text('can\'t login')));
                              }
                            },
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xfffca148))),
                            child:const Text(
                              'Google.',
                              style:
                              TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            SizedBox(
                              width: height,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xfffca148),
                                ),
                              ),
                            )
                          ],
                        ),
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
