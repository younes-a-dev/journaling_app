import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_size.dart';
import '../../../../core/widgets/cm_app_bar.dart';
import '../../data/model/article_model.dart';
import '../widgets/article_item.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

List<ArticleModel> articles = [
  ArticleModel(
    id: '1',
    title: 'Money Management',
    imageUrl: 'https://www.centralcharts.com/medias/social/guides/g4-r5.png',
    description:
        'Money management on Forex is an essential element for success in the markets. This allows you to control risk on all your trades and on your trading account',
    content:
        'Money management on Forex is an essential element for success in the markets. This allows you to control risk on all your trades and on your trading account. Managing risk well is not only to avoid razing your account, it is also a way to maximize your Forex trading performance. Often overlooked by novice traders, money management is what makes the difference between a winning and losing trading strategy.',
    author: 'amirali',
    dateTime: DateTime.now(),
    readTime: 12,
  ),
  ArticleModel(
    id: '2',
    title: '7 Incredible Benefits of Online Forex Trading',
    imageUrl:
        'https://images.prismic.io/statrys/cf86d77c-eab5-4990-a9f8-194cefaf4bb9_ENG_forex-trading-benefits.png',
    description:
        'What if you could start a business and work from anywhere? What if the cost of starting a said business could be as low as 1? What if you only had to work an hour a day to generate upwards of 100,000 per year?',
    content:
        'When you go on holiday to a foreign country, generally you would need to convert your local currency into the currency corresponding to the country you are visiting. In short, you are making a trade and-exchanging- currencies.',
    author: 'amirali',
    dateTime: DateTime.now(),
    readTime: 8,
  ),
];

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CmAppBar(
                title: 'Articles',
              ),
              gapH16,
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (ctx, index) {
                    return ArticleItem(article: articles[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
