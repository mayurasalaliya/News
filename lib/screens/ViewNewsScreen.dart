import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprots/model/NewsModel.dart';
import 'package:url_launcher/url_launcher.dart';

Data? data;
String titleName = "";

class ViewNews extends StatefulWidget {
  const ViewNews({super.key});

  @override
  State<StatefulWidget> createState() => _MyViewNews();
}

class _MyViewNews extends State<ViewNews> {
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Data;

    titleName = ModalRoute.of(context)!.settings.name as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(titleName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
          statusBarIconBrightness: Brightness.light,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For IOS (dark icons)
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      imageUrl: data!.imageUrl!,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Text(
                  data!.title!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${data!.date!} ${data!.time!}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.grey)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Text(data!.content!)),
            ]))),
            TextButton(
              onPressed: () => _launchUrl(data!.readMoreUrl!),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(double.infinity, 40),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Colors.blue,
                  alignment: Alignment.center,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero))),
              child: const Text(
                "Read More",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String s) async {
    try {
      await launchUrl(Uri.parse(data!.readMoreUrl!),
          mode: LaunchMode.inAppWebView);
    } catch (ex) {
      ex.toString();
    }
  }
}
