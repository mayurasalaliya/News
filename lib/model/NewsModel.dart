class NewsModel {
  String? category;
  List<Data>? data;
  bool? success;

  NewsModel({this.category, this.data, this.success});

  NewsModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class Data {
  String? author;
  String? content;
  String? date;
  String? id;
  String? imageUrl;
  String? readMoreUrl;
  String? time;
  String? title;
  String? url;

  Data(
      {this.author,
        this.content,
        this.date,
        this.id,
        this.imageUrl,
        this.readMoreUrl,
        this.time,
        this.title,
        this.url});

  Data.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    date = json['date'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    readMoreUrl = json['readMoreUrl'];
    time = json['time'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['content'] = content;
    data['date'] = date;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['readMoreUrl'] = readMoreUrl;
    data['time'] = time;
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}