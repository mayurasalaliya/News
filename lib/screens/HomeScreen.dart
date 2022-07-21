import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sprots/model/NewsModel.dart';
import 'package:sprots/screens/ViewNewsScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Data>? trendingData;
  List<Data>? sportsData;
  List<Data>? politicsData;
  List<Data>? entertainmentData;

  Future getTrendingNews() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://inshorts.deta.dev/news?category=\""));

      if (response.statusCode == 200) {
        setState(() {
          trendingData = NewsModel.fromJson(jsonDecode(response.body)).data;
        });
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future getSportsNews() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://inshorts.deta.dev/news?category=sports"));

      if (response.statusCode == 200) {
        setState(() {
          sportsData = NewsModel.fromJson(jsonDecode(response.body)).data;
        });
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future getPoliticsNews() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://inshorts.deta.dev/news?category=politics"));

      if (response.statusCode == 200) {
        setState(() {
          politicsData = NewsModel.fromJson(jsonDecode(response.body)).data;
        });
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future getEntertainmentNews() async {
    try {
      http.Response response = await http.get(
          Uri.parse("https://inshorts.deta.dev/news?category=entertainment"));

      if (response.statusCode == 200) {
        setState(() {
          entertainmentData =
              NewsModel.fromJson(jsonDecode(response.body)).data;
        });
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _launchUrl(String s) async {
    try {
      await launchUrl(Uri.parse(s), mode: LaunchMode.inAppWebView);
    } catch (ex) {
      ex.toString();
    }
  }

  @override
  void initState() {
    getTrendingNews();
    getSportsNews();
    getPoliticsNews();
    getEntertainmentNews();
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About Developer'),
          content: const Text(
              "Hello, My name is Mayur Asalaliya. I am a student of L.D. College of Engineering, Ahmedabad."),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getCard(String imgUrl, String title, String dateTime) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 1.57,
        child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      imageUrl: imgUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dateTime,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey),
                      )),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News"),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                _showMyDialog();
              },
            )
          ],
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.blue,
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For IOS (dark icons)
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/ic_inshorts.png",
                          height: 70, width: 70),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "News",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  )),
              ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("Terms & Conditions"),
                  onTap: () {
                    _launchUrl("https://www.inshorts.com/tnc");
                  }),
              ListTile(
                leading: const Icon(Icons.policy),
                title: const Text(
                  "Privacy Policy",
                ),
                onTap: () {
                  _launchUrl("https://www.inshorts.com/privacy");
                },
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text("Trending News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            const SizedBox(
              width: 130,
              child: Divider(height: 20, thickness: 2, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            trendingData == null
                ? const SizedBox(
                    height: 280,
                    child: Center(child: CircularProgressIndicator()))
                : SizedBox(
                    height: 280,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            trendingData == null ? 0 : trendingData?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ViewNews(),
                                    settings: RouteSettings(
                                        arguments: trendingData![index],
                                        name: "Trending News")),
                              );
                            },
                            child: getCard(
                                trendingData![index].imageUrl!,
                                trendingData![index].title!,
                                "${trendingData![index].date!} ${trendingData![index].time!}"),
                          );
                        })),
            const SizedBox(
              height: 20,
            ),
            const Text("Sports News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            const SizedBox(
              width: 130,
              child: Divider(height: 20, thickness: 2, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            sportsData == null
                ? const SizedBox(
                    height: 280,
                    child: Center(child: CircularProgressIndicator()))
                : SizedBox(
                    height: 280,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sportsData == null ? 0 : sportsData?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ViewNews(),
                                      settings: RouteSettings(
                                          arguments: sportsData![index],
                                          name: "Sports News")),
                                );
                              },
                              child: getCard(
                                  sportsData![index].imageUrl!,
                                  sportsData![index].title!,
                                  "${sportsData![index].date!} ${sportsData![index].time!}"));
                        })),
            const SizedBox(
              height: 20,
            ),
            const Text("Politics News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            const SizedBox(
              width: 130,
              child: Divider(height: 20, thickness: 2, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            politicsData == null
                ? const SizedBox(
                    height: 280,
                    child: Center(child: CircularProgressIndicator()))
                : SizedBox(
                    height: 280,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            politicsData == null ? 0 : politicsData?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ViewNews(),
                                      settings: RouteSettings(
                                          arguments: politicsData![index],
                                          name: "Politics News")),
                                );
                              },
                              child: getCard(
                                  politicsData![index].imageUrl!,
                                  politicsData![index].title!,
                                  "${politicsData![index].date!} ${politicsData![index].time!}"));
                        })),
            const SizedBox(
              height: 20,
            ),
            const Text("Entertainment News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            const SizedBox(
              width: 130,
              child: Divider(height: 20, thickness: 2, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            entertainmentData == null
                ? const SizedBox(
                    height: 280,
                    child: Center(child: CircularProgressIndicator()))
                : SizedBox(
                    height: 280,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: entertainmentData == null
                            ? 0
                            : entertainmentData?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ViewNews(),
                                      settings: RouteSettings(
                                          arguments: entertainmentData![index],
                                          name: "Entertainment News")),
                                );
                              },
                              child: getCard(
                                  entertainmentData![index].imageUrl!,
                                  entertainmentData![index].title!,
                                  "${entertainmentData![index].date!} ${entertainmentData![index].time!}"));
                        }))
          ],
        )));
  }
}
