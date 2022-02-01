// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mapnpospoc/constants.dart';

class SectionLeft extends StatefulWidget {
  const SectionLeft({Key? key}) : super(key: key);

  @override
  State<SectionLeft> createState() => _SectionLeftState();
}

class _SectionLeftState extends State<SectionLeft> {
  final List<Map<String, String>> dropdownList = [
    {"text": "One", "value": "1"},
    {"text": "Two", "value": "2"},
    {"text": "Three", "value": "3"},
    {"text": "Four", "value": "4"},
    {"text": "Five", "value": "5"},
  ];

  late String selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            color: Colors.orange,
            shape: RoundedRectangleBorder(borderRadius: appBorderRadius),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hello, Atish!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Welcome Home! The air quality is good and fresh \nyou can go out today",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(Icons.thermostat),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "25",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "deg",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "C",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Outdoor temperature")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.cloud_queue),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Fuzzy cloudy weather")
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Atish's Home",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Icon(Icons.directions_boat_filled_sharp),
                    Text("35%"),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.thermostat),
                    Text("15 C"),
                    SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: 120,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white54, borderRadius: appBorderRadius),
                        padding: EdgeInsets.all(4),
                        child: DropdownButton(
                          value: selectedValue,
                          underline: Container(),
                          isExpanded: true,
                          isDense: true,
                          borderRadius: appBorderRadius,
                          hint: Text("Select"),
                          items: dropdownList.map((element) {
                            return DropdownMenuItem<String>(value: element["value"], child: Text(element["text"].toString()));
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Text("Card"),
        ],
      ),
    );
  }
}

class SectionRight extends StatelessWidget {
  const SectionRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text("hihihihihihihi"),
    );
  }
}
