import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/shared.services.dart';
import 'package:news_app/screens/homePage/view/home.page.dart';
import 'package:news_app/screens/newsPage/controller/new.page.controller.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/widgets/news.tile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Network network = Network();
  SharedService sharedService = SharedService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('News'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
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
              sharedService.saveUserLoggedInStatus(false);
              if (!mounted) return;
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: network.getNews(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return NewsTile(index: index, snapshot: snapshot);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
