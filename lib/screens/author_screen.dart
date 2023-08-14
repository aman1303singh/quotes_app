import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/models/quotes_model.dart';

// ignore: must_be_immutable
class AuthorScreen extends StatefulWidget {
  List<QuotesModel> list;
  String author;
  bool isQuote;
  AuthorScreen(
      {super.key,
      required this.list,
      required this.author,
      this.isQuote = false});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            color: widget.isQuote ? Colors.lightBlue[100] : Colors.transparent,
            child: Text(
              widget.author,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                            widget.list[index].quotes.toString(),
                            style:
                                TextStyle(color: widget.list[index].fontColor),
                          ),
                          subtitle: widget.isQuote
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(widget.list[index].author),
                                )
                              : const SizedBox())
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const DottedDashedLine(
                  axis: Axis.horizontal,
                  height: 2.0,
                  width: double.infinity,
                );
              },
            ))
          ],
        ));
  }
}
