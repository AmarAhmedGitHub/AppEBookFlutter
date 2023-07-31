import 'package:flutter/material.dart';
import 'package:library/Model/BookModle/BookModle.dart';
import 'package:library/utls/api/user_service.dart';

import 'ListSearchBook.dart';

class DataSearch extends SearchDelegate<String> {
  List<dynamic> list;

  DataSearch({required this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchBook(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                Book book = snapshot.data[i];
                print(book);
                return BooksList(
                  book: book,
                );
              });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchlist = query.isEmpty
        ? list
        : list.where((p) => p['name'].toLowerCase().contains(query)).toList();
    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.book),
            title: Text(searchlist[i]['name']),
            onTap: () {
              query = searchlist[i]['name'];
              showResults(context);
            },
          );
        });
  }
}
