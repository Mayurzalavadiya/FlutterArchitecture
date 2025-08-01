import 'package:hive/hive.dart';

part 'get_quotes_response.g.dart';

class GetQuotesResponse {
  List<Quotes>? quotes;
  int total = 0;
  int? skip;
  int? limit;

  GetQuotesResponse({this.quotes, this.total = 0, this.skip, this.limit});

  GetQuotesResponse.fromJson(Map<String, dynamic> json) {
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(new Quotes.fromJson(v));
      });
    }
    total = json['total'] ?? 0;
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quotes != null) {
      data['quotes'] = this.quotes!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

@HiveType(typeId: 3)
class Quotes {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? quote;
  @HiveField(2)
  String? author;
  @HiveField(3)
  bool isFavourite = false;

  Quotes({this.id, this.quote, this.author, this.isFavourite = false});

  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quote = json['quote'];
    author = json['author'];
    isFavourite = json['isFavourite'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote'] = this.quote;
    data['author'] = this.author;
    data['isFavourite'] = this.isFavourite;
    return data;
  }

  /// ✅ Add copyWith method here
  Quotes copyWith({
    int? id,
    String? quote,
    String? author,
    bool? isFavourite,
  }) {
    return Quotes(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      author: author ?? this.author,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
