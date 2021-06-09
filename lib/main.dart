import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

import './screens/filters_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './models/meal.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritMeals = [];

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoritMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.amberAccent,
          canvasColor: Color.fromRGBO(255, 253, 237, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 21, 2, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 21, 2, 1),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      routes: {
        '/': (context) => TabsScreen(_favoritMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routeName: (context) =>
            MealDetailsScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (crx) => CategoryMealsScreen(_availableMeals));
      },
    );
  }
}
