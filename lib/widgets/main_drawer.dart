import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTitle(IconData icon, String title, Function tapAction) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(
          icon,
          size: 36,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: tapAction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Text(
                'Cooking Up!',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTitle(Icons.restaurant, 'Meals', () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTitle(Icons.settings, 'Filters', () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          })
        ],
      ),
    );
  }
}
