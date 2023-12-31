import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_app/notes_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_management/home_screen.dart';
// import 'package:library_management/profile_screen.dart';
import 'package:library_management/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List dropDownListData = [
    {"title": "Admin", "value": "1"},
    {"title": "Student", "value": "2"},
  ];

  String selectedCourseValue = "";
  //form key
  final _formkey = GlobalKey<FormState>();

  //Editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }

        if (!regex.hasMatch(value)) {
          return ("Enter valid Password(Min 6 characters)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 218, 151, 17),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage(
                            "assets/librario.jpg",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      emailField,
                      const SizedBox(
                        height: 25,
                      ),
                      passwordField,
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      // InputDecorator(
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //     contentPadding: const EdgeInsets.all(10),
                      //   ),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton<String>(
                      //       value: selectedCourseValue,
                      //       isDense: true,
                      //       isExpanded: true,
                      //       menuMaxHeight: 350,
                      //       items: [
                      //         const DropdownMenuItem(
                      //             child: Text(
                      //               "Login as",
                      //               style: TextStyle(
                      //                   color:
                      //                       Color.fromARGB(195, 102, 98, 98)),
                      //             ),
                      //             value: ""),
                      //         ...dropDownListData
                      //             .map<DropdownMenuItem<String>>((e) {
                      //           return DropdownMenuItem(
                      //               child: Text(e['title']), value: e['value']);
                      //         }).toList(),
                      //       ],
                      //       onChanged: (newValue) {
                      //         setState(
                      //           () {
                      //             selectedCourseValue = newValue!;
                      //             print(selectedCourseValue);
                      //           },
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 35,
                      ),
                      loginButton,
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                            },
                            child: const Text(
                              'SignUp',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 209, 132, 31)),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  //login function
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
