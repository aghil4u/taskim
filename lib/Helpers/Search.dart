import 'package:flutter/material.dart';
import 'package:task.im/Helpers/CustomShowSearch.dart' as x;

class ListingSearch extends x.SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: Action for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: Leading icon on left of app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: show some results based on input
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: show suggestins whn typing
    final ssuggestionList = query.isEmpty
        ? ["asdasda", "asdasdasdasd", "asdasdasdasdasd"]
        : ["some other stuff", "asdasdasdasd", "asdasdasdasdasd"];

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.location_city),
            title: Text(ssuggestionList[index]),
          ),
      itemCount: ssuggestionList.length,
    );
  }
}
