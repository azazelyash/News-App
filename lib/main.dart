import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/auth/shared.services.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/screens/homePage/view/home.page.dart';
import 'package:news_app/screens/loginPage/view/login.page.view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/screens/newsPage/view/news.page.view.dart';

Widget defaultHome = const HomePage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  SharedService().getUserLoggedInStatus().then((value) {
    if (value == true) {
      defaultHome = const NewsPage();
    } else {
      defaultHome = const HomePage();
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: defaultHome,
    );
  }
}
