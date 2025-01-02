import 'package:flutter/material.dart';
import 'package:flutter_meals/providers/favorites_provider.dart';
import 'package:flutter_meals/providers/filters_provider.dart';
import 'package:flutter_meals/providers/meals_provider.dart';
import 'package:flutter_meals/resourse/widget/main_drawer.dart';
import 'package:flutter_meals/screen/categories_screen.dart';
import 'package:flutter_meals/screen/filters_screen.dart';
import 'package:flutter_meals/screen/meal_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactosFree: false,
  Filter.vegetrarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }

// Navigator.of(context).pushReplacement(

    //  else {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    var meals = ref.watch(mealsProvider);
    var activeFilters = ref.watch(filtersProvider);
    final avilableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      avilableMeals: avilableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      var favoriteMeals = ref.watch(favoritesMealsProvider);

      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'You\'r Favorites!';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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
