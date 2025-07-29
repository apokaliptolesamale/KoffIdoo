// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/app/routes/route_pages.dart';

class CustomBotoonNavBar extends StatefulWidget {
  int index;
  CustomBotoonNavBarState? _state;
  late Function(int index) currentIndex;
  CustomBotoonNavBar({
    Key? key,
    required this.index,
  }) : super(key: key) {
    _state = CustomBotoonNavBarState();
    currentIndex = (index) {
      if (getState.mounted) {
        getState.setIndex(index);
      }
    };
  }
  factory CustomBotoonNavBar.fromRoute(
    String route, {
    List<String>? listOfPages,
  }) {
    return CustomBotoonNavBar(
      index: RoutePages.fromRoute(
        route,
        listOfPages: listOfPages ?? [],
      ).index,
    );
  }

  CustomBotoonNavBarState get getState => _state ?? createState();

  @override
  CustomBotoonNavBarState createState() => _state = CustomBotoonNavBarState();

  CustomBotoonNavBar setIndex(int newIndex) {
    if (getState.mounted) getState.setIndex(index = newIndex);
    return this;
  }
}

class CustomBotoonNavBarState extends State<CustomBotoonNavBar> {
  int? index;

  List bottons = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unselectedIconTheme =
        theme.bottomNavigationBarTheme.unselectedIconTheme;
    final selectedIconTheme = theme.bottomNavigationBarTheme.selectedIconTheme;
    final selectedLabelStyle =
        theme.bottomNavigationBarTheme.selectedLabelStyle;
    final unselectedLabelStyle =
        theme.bottomNavigationBarTheme.unselectedLabelStyle;
    final showSelectedLabels =
        theme.bottomNavigationBarTheme.showSelectedLabels;
    return BottomNavigationBar(
      currentIndex: index!,
      selectedIconTheme: selectedIconTheme,
      unselectedIconTheme: unselectedIconTheme,
      selectedLabelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      showSelectedLabels: showSelectedLabels,
      onTap: (int i) {
        setState(() {
          widget.currentIndex(index = i);
          RoutePages.instance.index = i;
          RoutePages.instance.navegate();
        });
      },
      type: BottomNavigationBarType.fixed,
      //selectedItemColor: Colors.blue[800],
      backgroundColor: Colors.lightBlue[100],
      //unselectedItemColor: Colors.black,
      enableFeedback: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.details),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "",
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    index = widget.index;
    bottons = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.details),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: "",
      )
    ];
    count = bottons.length;
  }

  void setIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
}
