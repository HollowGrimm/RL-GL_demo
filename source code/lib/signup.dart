import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<void> register(email, password) async {
    try {
      final registerAttempt = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref.child(registerAttempt.user!.uid).update({
        "Wins": 0,
        "Losses": 0,
      });
    } on FirebaseAuthException catch (error) {
      print(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 44.0,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "User Email",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.mail,
                        color: Color.fromRGBO(57, 255, 20, 92)),
                  ),
                ),
                const SizedBox(
                  height: 26.0,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "User Password",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromRGBO(57, 255, 20, 92)),
                  ),
                ),
                const SizedBox(
                  height: 26.0,
                ),
                TextField(
                  controller: confirmController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromRGBO(57, 255, 20, 92)),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: const Color.fromRGBO(57, 255, 20, 92),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    onPressed: () async {
                      if (passwordController.text == confirmController.text) {
                        register(emailController.text, passwordController.text);
                        Navigator.pop(context);
                      } else {
                        print("passwords do not match");
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ])),
    );
  }
}
