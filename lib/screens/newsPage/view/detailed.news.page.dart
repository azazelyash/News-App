import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';

class DetailedNewsPage extends StatelessWidget {
  const DetailedNewsPage({super.key, required this.data});
  final dynamic data;

  // function to extract date from the string
  String? getDate(String? date) {
    if (date == null) {
      return null;
    }
    String? temp = "${date.substring(0, 10)}, ${date.substring(11, 16)}";
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: SizedBox(
          // width: MediaQuery.of(context).size.width / 2.2,
          child: Text(
            data!.source,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image(
                    image: NetworkImage((data!.urlToImage == null) ? kTempURl : data!.urlToImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                data!.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data!.author ?? 'Unknown Author',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    getDate(data!.date) ?? 'Unknown Date',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                data!.description ?? 'No Description',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
