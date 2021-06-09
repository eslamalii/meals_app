import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vagetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vagetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTitle(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
      subtitle: Text(
        description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegetarian': _vagetarian,
                'vegan': _vegan,
              };
              widget.saveFilters(selectedFilters);
              Navigator.of(context).pushReplacementNamed('/');
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTitle(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  _glutenFree,
                  (value) {
                    setState(
                      () {
                        _glutenFree = value;
                      },
                    );
                  },
                ),
                _buildSwitchListTitle(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  _lactoseFree,
                  (value) {
                    setState(
                      () {
                        _lactoseFree = value;
                      },
                    );
                  },
                ),
                _buildSwitchListTitle(
                  'Vegetarian',
                  'Only include Vegetarian meals',
                  _vagetarian,
                  (value) {
                    setState(
                      () {
                        _vagetarian = value;
                      },
                    );
                  },
                ),
                _buildSwitchListTitle(
                  'Vegan',
                  'Only include Vegen meals',
                  _vegan,
                  (value) {
                    setState(
                      () {
                        _vegan = value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
