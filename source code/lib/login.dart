import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_knight/homescreen.dart';
import 'package:rhythm_knight/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Red Light, Green Light",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Center(
            child: Text(
              "Demo",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold),
            ),
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
              prefixIcon:
                  Icon(Icons.mail, color: Color.fromRGBO(57, 255, 20, 92)),
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
              prefixIcon:
                  Icon(Icons.lock, color: Color.fromRGBO(57, 255, 20, 92)),
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
                User? user = await loginUsingEmailPassword(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context)
                    .then((value) {
                  if (value != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  }
                  return null;
                });
                print(user);
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
