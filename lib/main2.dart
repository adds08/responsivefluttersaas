// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:core';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        // body: MapWidget(),
        body: MainApp(),
      ),
    );
  }
}

class Categories {
  final String name;
  List<FoodItem> foods = [];

  Categories(this.name);
  get category => name;
  set setCategory(String name) => {name = name};
  void foodsFromMap(FoodItem food) {
    foods.add(food);
  }
}

class FoodItem {
  final String name;
  final String picture;
  final double price;
  final Categories category;

  FoodItem(this.name, this.picture, this.price, this.category);
}

List<Map<String, List>> mapsmock = [
  {
    "hotdish": ["Soup", "Cereal", "Vegetable Soup", "Tea"]
  },
  {
    "colddish": ["Kimchi", "Flavoured Tea", "Ice Cream", "Salad"]
  },
  {
    "alcohol": ["Rum", "Whiskey", "Beer", "Wine", "Vodka"]
  }
];

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int menuIndex;
  List<String> selectedFood = [];
  @override
  void initState() {
    super.initState();
    menuIndex = 0;
    // print(mapsmock[menuIndex].values.first.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      children: [
        Expanded(
            flex: 6,
            child: Container(
              color: Colors.amber,
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.pink,
                      child: ListView.builder(
                        itemCount: mapsmock[menuIndex].values.first.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                selectedFood.add(mapsmock[menuIndex].values.first[index]);
                              });
                            },
                            title: Text("${mapsmock[menuIndex].values.first[index]}"),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        itemCount: mapsmock.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              color: (menuIndex == index) ? Colors.redAccent : Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  menuIndex = index;
                                });
                              },
                              child: Text(
                                mapsmock[index].keys.first.toString().toUpperCase(),
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Expanded(
            flex: 4,
            child: Container(
              color: Colors.blueAccent,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 32),
                itemCount: selectedFood.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            selectedFood.removeAt(index);
                          });
                        },
                        title: Text(
                          selectedFood[index],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ));
                },
              ),
            ))
      ],
    ));
  }
}
