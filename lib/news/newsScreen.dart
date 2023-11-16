import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'data.dart';
import 'details.dart';

class PageOfNewsForShow extends StatefulWidget {
  const PageOfNewsForShow({Key? key}) : super(key: key);

  @override
  State<PageOfNewsForShow> createState() => _PageOfNewsForShowState();
}

final List<String> _watched = [];

DateTime now = DateTime.now();

// Define the desired format
DateFormat dateFormat = DateFormat('MMMd');

String formattedDate = dateFormat.format(now);

class _PageOfNewsForShowState extends State<PageOfNewsForShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 7, 10),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          color: Color.fromARGB(255, 7, 7, 10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Stack(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReadAboutArticleOnTap(
                                newsModel: FootballNewsData.stats[index]),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Container(
                                  height: 175,
                                  width: double.infinity,
                                  color: Colors.grey,
                                  child: Image.network(
                                    FootballNewsData.stats[index].img,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            FootballNewsData.stats[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            FootballNewsData.stats[index].description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: FootballNewsData.stats.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
