import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/domain/model/user_profile.dart';
import 'package:lushan/utils/config_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                      'Register',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('WelCome', style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1),
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
                                return 'input phone';
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
                            controller: _password,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'input password';
                              }
                              return null;
                            },
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
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  _signUp();
                                }
                              },
                              child: const Text('Register'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Already Have An Account? ',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText1),
                                TextSpan(
                                    text: 'Sign In',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.popAndPushNamed(context, 'signIn');
                                      },
                                    style: Theme
                                        .of(context)
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

  void _signUp() async {
    var response = await UseCaseLocator.registerUseCase
        .execute(_phone.text, _password.text);
    if (response.success) {
      var userProfile =
      UserProfile(response.uid!, response.avatar!, response.nickname!);
      ConfigUtils.saveUserToken(response.token!);
      ConfigUtils.saveUserProfile(userProfile);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(" 注册成功")));
      Navigator.of(context).popAndPushNamed('home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            " unknown error",
          )));
    }
  }
}
