import 'package:budget_tracker/helper/last_sunday.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int _selectedDate = DateTime.now().day;
  List<DateTime> week = [];
  List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    _selectedDate = DateTime.now().day;
    super.initState();
    week = getWeekFromLastSunday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.80),
      body: body(),
    );
  }

  Widget body() {
    return Column(children: [
      topBar(),
      Text(
        "$_selectedDate",
        style: const TextStyle(color: Colors.white),
      )
    ]);
  }

  Container topBar() {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Daily Transactions",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (index) {
                            return calendarCircle(index);
                          }))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column calendarCircle(int index) {
    String date = formatter.format(week[index]);
    return Column(
      children: [
        Text(
          days[index],
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = week[index].day;
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color:
                  _selectedDate == week[index].day ? Colors.white : Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                date.substring(date.length - 2),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: _selectedDate == week[index].day
                      ? Colors.blue
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
