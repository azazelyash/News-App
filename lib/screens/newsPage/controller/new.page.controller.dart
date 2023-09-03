import 'dart:async';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/screens/newsPage/model/news.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Future<List<NewsModel>> getNews() async {
    String key = dotenv.env['API_KEY'] ?? '';
    List<NewsModel> news = [];

    try {
      var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=$key'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data['articles'].forEach((element) {
          news.add(NewsModel.fromJson(element));
        });

        log(news.toString());
      }
    } catch (e) {
      log(e.toString());
    }

    return news;
  }
}
