// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_final_fields, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:winnerfootball/presentation/matc/data/datax.dart';
import 'package:winnerfootball/widgets/other/data.dart';

class CalendarScreenPage extends StatefulWidget {
  @override
  State<CalendarScreenPage> createState() => _CalendarScreenPageState();
}

class _CalendarScreenPageState extends State<CalendarScreenPage> {
  String selectedDayToData = '';
  final DATAAXS dataRepository = DATAAXS();
  final TextEditingController _emailController = TextEditingController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String _cachedEmail = 'Name';
  @override
  void initState() {
    super.initState();
    _loadCachedEmail();
    selectedDayToData = getCurrentDate();
  }

  void _loadCachedEmail() async {
    String? cachedEmail = await _storage.read(key: 'email');
    if (cachedEmail != null) {
      setState(() {
        _cachedEmail = cachedEmail;
      });
    }
  }

  void _showEmailInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Enter Name'),
          content: Column(
            children: [
              CupertinoTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                placeholder: 'Name',
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Save'),
              onPressed: () async {
                String email = _emailController.text;
                if (email.isNotEmpty) {
                  // Save the email to secure storage
                  await _storage.write(key: 'email', value: email);
                  setState(() {
                    _cachedEmail = email;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 7, 10),
      body: ListView(
        children: [
          const SizedBox(
            height: 70,
          ),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width * .3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/anim.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      _cachedEmail,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _showEmailInputDialog();
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange,
                        ),
                        child: const Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          SingleChildScrollView(
              child: TableCalendar(
            firstDay: DateTime.utc(2023, 1, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                selectedDayToData = getStringDataFromDate(_selectedDay!);
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
              titleCentered: true,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, events) {
                bool isSelectedDay = isSameDay(date, _selectedDay);

                return Center(
                  child: Container(
                    decoration: isSelectedDay
                        ? const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          )
                        : null,
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          color: isSelectedDay ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
          Container(
            child: FutureBuilder(
              future: dataRepository.fetchegsdfds(selectedDayToData),
              builder: (context, snapshot) {
                var matchData = snapshot.data;
                int length = 1;
                String time = '';
                String timeLeft = '';
                if (matchData != null) {
                  length = matchData.length;
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!['response'][0]['fixture']['timestamp'] *
                          1000);
                  time = DateFormat.Hm().format(dateTime);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                      'No matches on this day.\nCreate our match or choose another day!');
                } else {
                  return SizedBox(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      Text(
                                        snapshot.data!['response'][index]
                                                ['league']['name']
                                            .toString(),
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                child: Image.network(
                                                    snapshot.data!['response']
                                                            [index]['teams']
                                                        ['home']['logo']),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!['response']
                                                        [index]['teams']['home']
                                                        ['name']
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
                                                child: Image.network(
                                                    snapshot.data!['response']
                                                            [index]['teams']
                                                        ['away']['logo']),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!['response']
                                                        [index]['teams']['away']
                                                        ['name']
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
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
