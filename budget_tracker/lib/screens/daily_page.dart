import 'package:budget_tracker/helper/helper.dart';
import 'package:budget_tracker/widgets/expense_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String _selectedDate = "";
  List<DateTime> week = [];
  List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  @override
  void initState() {
    super.initState();
    _selectedDate = formatter.format(DateTime.now()).substring(0, 10);
    week = getWeekFromLastSunday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedDate.substring(_selectedDate.length - 2) ==
              DateTime.now().day.toString()
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          : null,
      backgroundColor: Colors.black.withOpacity(0.80),
      body: body(),
    );
  }

  Widget body() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          topBar(),
          Flexible(
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Text(formatDate(_selectedDate),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 180, 218, 255))),
              ),
              const Expense(
                  title: "Salary for 2023",
                  category: "Income",
                  amount: 200000,
                  expenditure: false),
              const Expense(
                  title: "title",
                  category: "category",
                  amount: 200,
                  expenditure: true),
              const Expense(
                  title: "title",
                  category: "category",
                  amount: 200,
                  expenditure: true),
              const Expense(
                  title: "title",
                  category: "category",
                  amount: 200,
                  expenditure: true),
            ]),
          ),
        ]);
  }

  Container topBar() {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      return calendarCircle(index);
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column calendarCircle(int index) {
    String date = formatter.format(week[index]).substring(0, 10);
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
              _selectedDate = formatter.format(week[index]).substring(0, 10);
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _selectedDate == date ? Colors.white : Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                date.substring(date.length - 2),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: _selectedDate == date ? Colors.blue : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
