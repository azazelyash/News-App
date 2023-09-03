import 'package:flutter/material.dart';
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
          onPressed: () {},
          child: const Text('Login'),
        ),
      ),
    );
  }
}
