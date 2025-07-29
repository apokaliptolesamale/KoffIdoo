import 'package:flutter/material.dart';


class CustomButtonNavigationBar extends StatelessWidget {
  final int index;

  final ValueChanged<int> onIndexSelected;
  const CustomButtonNavigationBar({
    Key? key,
    required this.index,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              color: index == 0 ? Colors.black : Colors.white,
              onPressed: () => onIndexSelected(0),
              icon: Image.asset(
                'assets/images/icons/app/enzona/iconos para probar/4.png',
                color: index == 0 ? Colors.black : Colors.white,
              ),
              // Icon(Icons.home),
            ),
            IconButton(
                color: index == 1 ? Colors.black : Colors.white,
                onPressed: () => onIndexSelected(1),
                icon: Icon(Icons.notifications)
                //BellWidget(),
                ),
            IconButton(
              color: index == 2 ? Colors.black : Colors.white,
              onPressed: () => onIndexSelected(2),
              icon: Icon(Icons.group),
            ),
            IconButton(
              color: index == 3 ? Colors.black : Colors.white,
              onPressed: () => onIndexSelected(3),
              icon: Icon(Icons.person),
            )
          ],
        ),
      ),
    );
  }
}
