import 'package:flutter/material.dart';
import 'package:quotes_app/models/quotes_model.dart';
import 'package:quotes_app/screens/author_screen.dart';

// ignore: must_be_immutable
class QuoteListile extends StatelessWidget {
  QuotesModel model;
  bool isListView;
  List<QuotesModel> listModel;
  QuoteListile(
      {super.key,
      required this.model,
      this.isListView = true,
      required this.listModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          model.quotes,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: model.fontColor,
            fontWeight: FontWeight.w400,
            fontSize: isListView ? 16 : 20,
          ),
        ),
        SizedBox(
          height: isListView ? 15 : 30,
        ),
        Align(
            alignment: isListView ? Alignment.bottomRight : Alignment.center,
            child: GestureDetector(
              onTap: () {
                List<QuotesModel> list = [];
                list.addAll(listModel
                    .where((element) => element.author == model.author));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthorScreen(
                              list: list,
                              author: model.author,
                            )));
              },
              child: Text(
                "- ${model.author}",
                style: TextStyle(
                  fontSize: isListView ? 14 : 18,
                ),
              ),
            )),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: isListView ? 0 : 30,
        ),
        isListView
            ? const SizedBox()
            : Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 5,
                children: List.generate(
                    model.tags.length,
                    (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthorScreen(
                                          list: listModel,
                                          author: model.tags[index],
                                          isQuote: true,
                                        )));
                          },
                          child: Card(
                            shape: const StadiumBorder(),
                            color: Colors.lightBlue[100],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                model.tags[index],
                              ),
                            ),
                          ),
                        )),
              )
      ],
    );
  }
}
