import 'package:auto_route/annotations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_first_app/ui/quotes/custom_search.dart';
import 'package:my_first_app/ui/quotes/store/quotes_store.dart';
import 'package:my_first_app/values/export.dart';
import 'package:my_first_app/widget/loading_widget.dart';

import '../../core/api/base_response/base_response.dart';
import '../../core/db/app_db.dart';
import '../../data/model/response/get_quotes_response.dart';
import '../../utils/extension.dart';
import '../../generated/l10n.dart';
import '../../widget/base_app_bar.dart';
import '../../widget/show_message.dart';

@RoutePage()
class QuotesPage extends StatefulWidget {
  static const String TAG = "QuotesPage";

  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;
  List<ReactionDisposer>? _disposers;
  late bool isConnected;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(
      color: Colors.white,
      iconBrightness: Brightness.dark, // for dark icons
    );

    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) setState(() => _showFab = true);
    });

    fetchData();
    _scrollController.addListener(_scrollListener);

    addDisposer();
  }

  Future<void> fetchData() async {
    isConnected = await hasInternetConnection();

    if (isConnected) {
      await quotesStore.getQuotesData(quotesStore.limit, quotesStore.skip);
    } else {
      await quotesStore.loadQuotesFromCache();
    }
  }

  void addDisposer() {
    _disposers ??= [
      // success reaction
      reaction((_) => quotesStore.getQuotesResponse, (
        GetQuotesResponse? response,
      ) {
        // if (response?.code == "1") {
        //   showMessage(response?.message ?? "");
      }),
      // error reaction
      reaction((_) => quotesStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          showCustomToast(context, message: errorMessage);
        }
      }),
    ];
  }

  void _scrollListener() {
    final total =
        quotesStore.getQuotesResponse?.total ??
        appDB.getValue("Quotes_totle", defaultValue: 0);

    if (kDebugMode) {
      print(QuotesPage.TAG + total.toString());
    }

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        quotesStore.quotesList.length < total!) {
      if (isConnected) {
        quotesStore.increment();
      } else {
        quotesStore.errorMessage = S.current.noActiveInternetConnection;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Floating Button
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AnimatedScale(
        scale: _showFab ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: _floatingButton(),
      ),
      //AppBar
      appBar: _appBar(),
      //Body UI
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10).r,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by author name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onChanged: (val) => quotesStore.setSearchQuery(val),
            ),
          ),

          Expanded(
            child: Observer(
              builder: (_) {
                return LoadingWidget(
                  status: quotesStore.isLoading,
                  child: quotesList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget quotesList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: quotesStore.filteredQuotes.length,
      itemBuilder: (context, index) {
        final quote = quotesStore.filteredQuotes[index];
        return Dismissible(
          key: Key(quote.id.toString()),
          direction: DismissDirection.horizontal,
          background: _slideRightBackground(quote.isFavourite),
          secondaryBackground: _slideLeftBackground(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              // Swipe left to delete
              // quotesStore.quotesList.removeWhere((q) => q.id == quote.id);
              await quotesStore.deleteQuote(quote.id); // persist delete
              showSnackBarMessage(context, 'Deleted quote at index $index');
              return true;
            } else if (direction == DismissDirection.startToEnd) {
              // Swipe right to favorite (or anything else)
              quotesStore.setFavourite(quote);
              await appDB.saveQuote(
                quote.copyWith(isFavourite: !quote.isFavourite),
              ); // persist update
              showCustomToast(
                context,
                message: 'Marked favorite: ${quote.author ?? ""}',
              );
              return false;
            }
            return false;
          },

          child: setItemView(quote),
        );
      },
    );
  }

  Widget setItemView(Quotes quote) {
    return Card(
      // shadowColor: Colors.grey,
      color: quote.isFavourite == true
          ? Colors.green.withOpacity(0.4) // highlight favorite
          : AppColor.purple.withOpacity(0.5),
      // elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                setText("Author : ", quote.author ?? "", textExtraBold),
                setText("", quote.id.toString(), textRegular),
              ],
            ),
            setText("Quotes : ", quote.quote ?? "", textExtraBold),
          ],
        ),
      ),
    );
  }

  Widget setText(String text, String title, TextStyle textExtraBold) {
    return RichText(
      text: TextSpan(
        text: text,
        style: textExtraBold,
        children: [TextSpan(text: title, style: textRegular)],
      ),
    );
  }

  Widget _slideRightBackground(bool isFavourite) {
    return Container(
      color: Colors.green,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        Icons.favorite,
        color: isFavourite ? Colors.cyan : Colors.white,
      ),
    );
  }

  Widget _slideLeftBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //AppBar
  PreferredSizeWidget _appBar() {
    return BaseAppBar(
      statusBarOverLap: true,
      titleWidgetColor: AppColor.white,
      centerTitle: false,
      scrolledUnderElevation: 20,
      backgroundColor: AppColor.purple.withOpacity(0.8),
      leadingIcon: true,
      preferredSize: Size.copy(Size.fromHeight(60)),
      showTitle: true,
      title: 'Quotes',
      leadingWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1518495973542-4542c06a5843?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
      ),
      action: [
        IconButton(
          onPressed: () {
            // Method to show the search bar
            showSearch(
              context: context,

              // Delegate to customize the search bar
              delegate: CustomSearchDelegate(
                quotesList: quotesStore.quotesList,
                (id) {
                  showCustomToast(context, message: id.toString());
                },
              ),
            );
          },
          icon: Icon(Icons.search, color: AppColor.white),
        ),
        IconButton(
          onPressed: () {
            openAddQuoteDialog(context);
          },
          icon: Icon(Icons.add_circle, color: AppColor.white),
        ),
        IconButton(
          onPressed: () {
            quotesStore.clearQuotes();
          },
          icon: Icon(Icons.delete, color: AppColor.black),
        ),
      ],
    );
  }

  // Floating Action Button
  Widget _floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        if (!_scrollController.hasClients) return;

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), // adjust as needed
          curve: Curves.easeOutCubic,
        );
      },
      child: const Icon(Icons.arrow_downward_outlined),
    );
    /*return FloatingActionButton(
      onPressed: () {
        if (!_scrollController.hasClients) return;

        final itemHeight = 150.0; // Estimated height of each item
        final visibleHeight = _scrollController.position.viewportDimension;
        final totalItems = quotesStore.filteredQuotes.length;

        // Calculate visible items on screen
        final visibleItems = (visibleHeight / itemHeight).floor();

        // Total remaining items not visible
        final remainingItems = totalItems - visibleItems;

        if (remainingItems <= 0) return;

        // Calculate exact scroll distance
        final targetOffset =
            _scrollController.position.pixels + (remainingItems * itemHeight);

        // Limit target offset to max scroll extent
        final safeOffset = targetOffset.clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );

        // Duration: 1 second per item
        final duration = Duration(seconds: remainingItems);

        // Smooth scroll to calculated position
        _scrollController.animateTo(
          safeOffset,
          duration: duration,
          curve: Curves.easeInOutCubic, // Very smooth
        );
        // if (quotesStore.filteredQuotes.isNotEmpty) {
        //   quotesStore.quotesList.remove(quotesStore.filteredQuotes[0]);
        // }
      },
      child: Icon(Icons.arrow_downward_outlined),
    );*/
  }

  void openAddQuoteDialog(BuildContext context) {
    String author = '';
    String quoteText = '';

    showCommonDialog(
      context: context,
      barrierDismissible: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                child: Icon(Icons.close),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Add New Quote",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(labelText: 'Author'),
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                author = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Quote'),
              textInputAction: TextInputAction.done,
              showCursor: true,
              cursorColor: AppColor.red,
              cursorWidth: 2,
              cursorRadius: Radius.circular(5),
              onChanged: (value) {
                quoteText = value;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                elevation: 5,
                shadowColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                minimumSize: Size(120, 50),
                maximumSize: Size(double.infinity, 56),
              ),
              onPressed: () {
                bool hasError = false;

                if (author.trim().isEmpty) {
                  showMessage("Author can't be empty");
                  hasError = true;
                }

                if (quoteText.trim().isEmpty) {
                  showMessage("Quote can't be empty");
                  hasError = true;
                }

                if (!hasError) {
                  quotesStore.addQuote(
                    Quotes(
                      id: quotesStore.quotesList.length + 1,
                      quote: quoteText,
                      author: author,
                    ),
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
