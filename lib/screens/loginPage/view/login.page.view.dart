import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/auth.services.dart';
import 'package:news_app/auth/shared.services.dart';
import 'package:news_app/screens/newsPage/controller/new.page.controller.dart';
import 'package:news_app/screens/newsPage/view/news.page.view.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/widgets/InputField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Network network = Network();
  AuthServices authServices = AuthServices();
  SharedService sharedService = SharedService();

  bool empty() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
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
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "SignIn to SocialX",
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
            InputWidget(nameController: _emailController, hintText: 'Email', suffixIcon: const Icon(Icons.person), obscureText: false),
            const SizedBox(
              height: 20,
            ),
            InputWidget(nameController: _passwordController, hintText: 'Password', suffixIcon: const Icon(Icons.email), obscureText: false),
            const SizedBox(
              height: 20,
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

            bool status = await authServices.signIn(_emailController.text, _passwordController.text);
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
                  content: Text('Invalid Credentials'),
                ),
              );
            }
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
