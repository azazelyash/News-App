import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/newsPage/view/detailed.news.page.dart';
import 'package:news_app/utils/constants.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.index,
    required this.snapshot,
  });

  final int index;
  final AsyncSnapshot snapshot;

  // function to extract date from the string
  String? getDate(String date) {
    if (date == null) {
      return null;
    }
    String? temp = "${date.substring(0, 10)}, ${date.substring(11, 16)}";
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => DetailedNewsPage(
              data: snapshot.data![index],
            ),
          ),
        );
      },
      child: Container(
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
                  getDate(snapshot.data![index].date) ?? "No Date",
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
            SizedBox(
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
      ),
    );
  }
}
