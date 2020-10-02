import "dart:convert";
import "dart:developer";

import "package:estagio_app/components/search_bar.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart" show rootBundle;

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List filteredList = [];
  List faqs = [];

  getJson() async {
    var json = jsonDecode(await rootBundle.loadString("assets/data/faq.json"));
    setState(() {
      faqs = json;
      filteredList = json;
    });
  }

  @override
  void initState() {
    getJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("FAQ"),
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: [
        _searchBar(),
        _listOfFaqs(),
      ],
    );
  }

  _listOfFaqs() {
    return filteredList.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: _buildFaqItem,
            itemCount: filteredList.length,
          )
        : Center(
            child: Text("Não foram encontrados resultados."),
          );
  }

  _searchBar() {
    return SearchBar(_filterList, "Palavra-chave");
  }

  _filterList(String term) {
    if (term.isEmpty) {
      setState(() {
        filteredList = List.from(faqs);
        _sortList();
      });
      return;
    }
    setState(() {
      filteredList = faqs
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();
      _sortList();
    });
  }

  void _sortList() {
    filteredList.sort((a, b) => b.date.compareTo(a.date));
  }

  Widget _buildFaqItem(BuildContext context, int index) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(filteredList[index]["question"]),
          Text(filteredList[index]["answer"]),
          filteredList[index]["images"].length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: filteredList[index]["images"].length,
                  itemBuilder: (context, itemIndex) => _buildImageItem(
                      context, itemIndex, filteredList[index]["images"]),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildImageItem(BuildContext context, int index, List images) {
    return Image.asset(images[index]);
  }
}
