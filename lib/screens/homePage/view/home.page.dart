import 'package:flutter/material.dart';
import 'package:news_app/screens/loginPage/view/login.page.view.dart';
import 'package:news_app/screens/signupPage/view/signup.page.view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffFE0000),
          title: const Text('SocialX'),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                border: Border.all(
                  color: const Color(0xfffe0000),
                  width: 1,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: Color(0xfffe0000),
                ),
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                physics: const BouncingScrollPhysics(),
                tabs: const <Widget>[
                  Tab(
                    text: "Login",
                  ),
                  Tab(
                    text: "Signup",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: const <Widget>[
                  LoginPage(),
                  SignUpPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
