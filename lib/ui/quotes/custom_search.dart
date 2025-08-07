import 'package:flutter/material.dart';
import 'package:my_first_app/data/model/response/get_quotes_response.dart';
import 'package:my_first_app/values/export.dart';
import 'package:my_first_app/widget/show_message.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Quotes> quotesList;
  final void Function(int id)? onClick;

  CustomSearchDelegate(this.onClick, {required this.quotesList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
            close(context, null);
            FocusScope.of(context).unfocus();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Quotes> matchQuery = quotesList
        .where((quote) => (quote.author ?? '')
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    return buildSearchList(matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Quotes> matchQuery = quotesList
        .where((quote) => (quote.author ?? '')
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    return buildSearchList(matchQuery);
  }

  Widget buildSearchList(List<Quotes> filteredList) {
    if (filteredList.isEmpty) {
      return Center(child: Text("No results found"));
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final quote = filteredList[index];
        return GestureDetector(
          onTap: () {
            onClick?.call(quote.id!);
            buildLeading(context);
          },
          child: Card(
            color: AppColor.teal.withSafeOpacity(0.5),
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Author: ${quote.author}", style: textExtraBold),
                  SizedBox(height: 4),
                  Text("Quote: ${quote.quote}", style: textRegular),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
