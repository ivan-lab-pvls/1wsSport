// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winnerfootball/presentation/matc/data/datax.dart';

class MatchBoardScreen extends StatefulWidget {
  const MatchBoardScreen({super.key});

  @override
  _MatchBoardScreenState createState() => _MatchBoardScreenState();
}

class _MatchBoardScreenState extends State<MatchBoardScreen> {
  final DATAAXS dataRepository = DATAAXS();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 7, 10),
      body: FutureBuilder(
        future: dataRepository.dataGeet(),
        builder: (context, snapshot) {
          var matchData = snapshot.data;
          int length = 1;
          String time = '';
          String timeLeft = '';
          if (matchData != null) {
            length = matchData.length;
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                snapshot.data!['response'][0]['fixture']['timestamp'] * 1000);
            time = DateFormat.Hm().format(dateTime);
            Duration remainingTime = dateTime.difference(DateTime.now());

            int hours = remainingTime.inHours * -1;
            int minutes = remainingTime.inMinutes.remainder(60) * -1;

            timeLeft = '${hours}h ${minutes}mins';
          } else {}

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text(
                'No matches on this day.\nCreate our match or choose another day!');
          } else {
            return ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: Image.asset('assets/images/stat_foot.png'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'TODAY',
                        style: TextStyle(
                          color: Color.fromARGB(255, 56, 56, 56),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1.4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFF222232)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      timeLeft,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Image.network(snapshot
                                                      .data!['response'][index]
                                                  ['teams']['home']['logo']),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              snapshot.data!['response'][index]
                                                      ['teams']['home']['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Image.network(snapshot
                                                      .data!['response'][index]
                                                  ['teams']['away']['logo']),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              snapshot.data!['response'][index]
                                                      ['teams']['away']['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      time,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
