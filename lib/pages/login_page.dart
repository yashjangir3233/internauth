import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logintask/components/google_tile.dart';
import 'package:logintask/components/my_button.dart';
import 'package:logintask/components/my_textfield.dart';
import 'package:logintask/services/auth_service.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in 
  void signUserIn() async {

    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child:CircularProgressIndicator() ,
          );
      },
      );

    // try sign in 
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email:emailController.text,
      password:passwordController.text,
    );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
      //pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  //error message to user
  void showErrorMessage(String message) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Center(child: Text(message,style: const TextStyle(color: Colors.white,fontSize: 18),)),
      );
    },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height:50),
          
                //logo
                Icon(
                  Icons.lock,
                  size:100,
                ),
          
                SizedBox(height: 50),
          
                //welcome back
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color:Color(0xFF616161),
                    fontSize: 16,
                  ),
                ),
                
                const SizedBox(height: 25,),
          
                //email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  ),
          
                const SizedBox(height: 25),
          
                //password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),
                
                //forgot pass
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context,MaterialPageRoute(builder: (context){
                            return ForgotPasswordPage();
                          }));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25,),
          
                //sign in 
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                  ),
          
                const SizedBox(height: 50,),
                
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 30,),
          
                //google sign in 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GoogleTile(
                      onTap: () {AuthService().signInWithGoogle();},
                      imagePath: 'lib/images/google.png')
                  ],
                ),
          
                const SizedBox(height: 50,),
                
                //not a member?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color:Colors.grey[700]),
                      ),
                    const SizedBox(width:4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],)
              ],
              ),
          ),
        ),
      ),
    );
  }
}