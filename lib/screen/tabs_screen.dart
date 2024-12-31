import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/resourse/widget/main_drawer.dart';
import 'package:flutter_meals/screen/categories_screen.dart';
import 'package:flutter_meals/screen/meal_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoBar(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void _toggleMaleFavoriteStatus(Meal meal) {
    final isExist = _favoriteMeals.contains(meal);

    if (isExist) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoBar('Removed from favorite meal.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoBar('Added to favorite meal.');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMaleFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMaleFavoriteStatus,
      );
      activePageTitle = 'You\'r Favorites!';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: const MainDrawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
