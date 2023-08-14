import 'dart:convert';

import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_app/models/quotes_model.dart';
import 'package:quotes_app/widgets/quotes_listtile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListView = true;
  bool isLoading = false;
  List<QuotesModel> quotes = [];

  Future<void> readjson() async {
    setState(() {
      isLoading = true;
    });
    final String response =
        await rootBundle.loadString('assets/jsons/quotes.json');
    final data = await json.decode(response);
    for (Map<String, dynamic> map in data["quotes"]) {
      quotes.add(QuotesModel.fromJson(map));
    }
    setState(() {
      isLoading = false;
    });
    print(quotes.length);
  }

  @override
  void initState() {
    super.initState();
    readjson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    " ''Quotes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: isListView
                            ? Colors.lightBlue[100]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.list,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          isListView = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: !isListView
                            ? Colors.lightBlue[100]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.view_column_outlined,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          isListView = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: isListView
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                itemBuilder: (context, index) {
                                  return QuoteListile(
                                      listModel: quotes, model: quotes[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return isListView
                                      ? const DottedDashedLine(
                                          axis: Axis.horizontal,
                                          height: 2.0,
                                          width: double.infinity,
                                        )
                                      : const SizedBox();
                                },
                                itemCount: quotes.length)
                            : PageView.builder(
                                itemBuilder: ((context, index) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 80),
                                      child: QuoteListile(
                                        listModel: quotes,
                                        model: quotes[index],
                                        isListView: false,
                                      ),
                                    ),
                                  );
                                }),
                                itemCount: quotes.length,
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget quotesbutton({
  required String text,
  required VoidCallback onPressed,
}) {
  return CupertinoButton(
    color: Colors.blue,
    child: Text(
      text,
      style: TextStyle(
          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
    ),
    onPressed: onPressed,
    borderRadius: BorderRadius.circular(10),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  );
}
