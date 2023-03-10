import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logintask/components/my_button.dart';
import 'package:logintask/components/my_textfield.dart';

import '../components/google_tile.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up
  void signUserUp() async {

    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child:CircularProgressIndicator() ,
          );
      },
      );

    // try create account
    try{
       //check if password and confirm password is same
       if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:emailController.text,
        password:passwordController.text,
        );
       } else {
        //show error message
        showErrorMessage("Passwords don't match!");
       }
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);

      //show error message
      showErrorMessage(e.code);
    }
  }

  //wrong email message
  void showErrorMessage(String message) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Center(child: Text(message,style: const TextStyle(color: Colors.white,fontSize: 18),)),
      );
    },);
  }


  // //wrong password message
  // void wrongPasswordMessage() {
  //   showDialog(context: context, builder: (context) {
  //     return const AlertDialog(
  //       backgroundColor: Colors.black,
  //       title: Center(child: Text('Incorrect Password',style: TextStyle(color: Colors.white,fontSize: 18),)),
  //     );
  //   },);
  // }

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
          
                //welcome 
                Text(
                  'Lets\'s create an account for you',
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
          
                const SizedBox(height: 10),
          
                //password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                //confirm password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),
          
                const SizedBox(height: 25,),
          
                //sign in 
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
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
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png')
                  ],
                ),
          
                const SizedBox(height: 50,),
                
                //not a member?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color:Colors.grey[700]),
                      ),
                    const SizedBox(width:4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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