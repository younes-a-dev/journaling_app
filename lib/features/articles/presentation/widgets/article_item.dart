import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trading_journal/features/articles/data/model/article_model.dart';

import '../../../../core/utils/constants/app_size.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({required this.article, super.key});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * .22,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          // padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  article.imageUrl!,
                  fit: BoxFit.cover,
                  width: size.width * .32,
                  height: size.height * .25,
                ),
              ),
              gapW16,
              Column(
                children: [
                  gapH8,
                  SizedBox(
                      width: size.width * .55,
                      child: Text(
                        article.title!,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xffbdbdbd), fontSize: 20,fontWeight: FontWeight.bold),
                      )),
                  gapH12,
                  SizedBox(
                      width: size.width * .55,
                      child: Text(
                        article.description!,
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xff757575), fontSize: 16),
                      )),
                  const Spacer(),
                  SizedBox(
                    width: size.width * .55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US')
                              .add_jm()
                              .format(article.dateTime!),
                          style: const TextStyle(color: Color(0xff616161)),
                        ),
                        SizedBox(
                            child: Text(
                          '${article.readTime!} min read',
                          style: const TextStyle(
                              color: Color(0xff757575), fontSize: 16),
                        )),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(
          height: 25,
          color: Color(0xff212121),
        ),
      ],
    );
  }
}
