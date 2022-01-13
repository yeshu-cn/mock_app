import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lushan/di/service_locator.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/domain/model/user_profile.dart';
import 'package:lushan/utils/config_utils.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Welcome', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            filled: true,
                            hintText: 'phone',
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white70),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _password,
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            filled: true,
                            hintText: 'password',
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white70),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Text("Recovery Password"),
                            onTap: () {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'New User? ',
                            style: Theme.of(context).textTheme.bodyText1),
                        TextSpan(
                            text: 'Register now',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.popAndPushNamed(context, 'signUp');
                              },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.red)),
                      ]))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  void _login() async {
    var response =
        await UseCaseLocator.loginUseCase.execute(_phone.text, _password.text);
    if (response.success) {
      // save user info
      var userProfile =
          UserProfile(response.uid!, response.avatar!, response.nickname!);
      ConfigUtils.saveUserToken(response.token!);
      ConfigUtils.saveUserProfile(userProfile);
      Navigator.popAndPushNamed(context, 'home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("login failed"),
      ));
    }
  }
}
