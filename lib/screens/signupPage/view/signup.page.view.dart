import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:news_app/auth/auth.services.dart';
import 'package:news_app/auth/shared.services.dart';
import 'package:news_app/screens/newsPage/view/news.page.view.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/widgets/InputField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthServices authServices = AuthServices();
  SharedService sharedService = SharedService();
  bool isChecked = false;

  bool empty() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty || isChecked == false) {
      return true;
    }
    return false;
  }

  bool validateEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 24,
        ),
        child: ListView(
          shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "SignUp to SocialX",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(),
            const SizedBox(
              height: 4,
            ),
            InputWidget(nameController: _nameController, hintText: 'Name', suffixIcon: const Icon(Icons.person), obscureText: false),
            const SizedBox(
              height: 20,
            ),
            InputWidget(nameController: _emailController, hintText: 'Email', suffixIcon: const Icon(Icons.email), obscureText: false),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            InternationalPhoneNumberInput(
              initialValue: PhoneNumber(isoCode: 'IN'),
              inputDecoration: InputDecoration(
                hintText: 'Phone Number',
                suffixIcon: const Icon(Icons.phone),
                suffixIconColor: kPrimaryColor,
                focusColor: kPrimaryColor,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
              cursorColor: kPrimaryColor,
              onInputChanged: (phone) {
                log(phone.toString());
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputWidget(nameController: _passwordController, hintText: 'Password', suffixIcon: const Icon(Icons.lock), obscureText: true),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text('I agree to the '),
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                Checkbox(
                  // fillColor: MaterialStateProperty.all<Color>(kPrimaryColor),
                  checkColor: Colors.white,
                  activeColor: kPrimaryColor,
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 48,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              kPrimaryColor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          onPressed: () async {
            if (empty()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all the fields'),
                ),
              );
              return;
            } else if (!validateEmail(_emailController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a valid email'),
                ),
              );
              return;
            } else if (!validatePassword(_passwordController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password must be atleast 6 characters'),
                ),
              );
              return;
            }

            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
              },
            );

            bool status = await authServices.signUp(_emailController.text, _passwordController.text);

            if (!mounted) return;
            Navigator.of(context).pop();
            if (status) {
              sharedService.saveUserLoggedInStatus(true);
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => const NewsPage(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }
          },
          child: const Text('SignUp'),
        ),
      ),
    );
  }
}
