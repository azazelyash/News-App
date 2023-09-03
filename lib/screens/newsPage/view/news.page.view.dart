import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/shared.services.dart';
import 'package:news_app/screens/homePage/view/home.page.dart';
import 'package:news_app/screens/newsPage/controller/new.page.controller.dart';
import 'package:news_app/utils/constants.dart';

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
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data![index].date,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                snapshot.data![index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                (snapshot.data![index].description == null) ? "No Description" : snapshot.data![index].description!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage((snapshot.data![index].urlToImage == null) ? kTempURl : snapshot.data![index].urlToImage!),
                              height: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
