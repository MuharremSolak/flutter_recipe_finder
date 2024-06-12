import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_service.dart';
import '../services/meal_service.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final MealService _mealService = MealService();
  List<dynamic> _favoriteMeals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteMeals(); // Favori yemekleri getir
  }

  void _fetchFavoriteMeals() async {
    setState(() => _isLoading = true);
    List<dynamic> meals = [];
    final favoritesService = Provider.of<FavoritesService>(context, listen: false);
    for (var id in favoritesService.favorites) {
      try {
        var meal = await _mealService.fetchMealDetails(id); // Yemek detaylarını getir
        meals.add(meal);
      } catch (e) {
        print('Error fetching favorite meal details: $e');
      }
    }
    setState(() {
      _favoriteMeals = meals;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Meals'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _favoriteMeals.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                _favoriteMeals[index]['strMealThumb'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(_favoriteMeals[index]['strMeal']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailScreen(meal: _favoriteMeals[index]), // Yemek detaylarına geçiş
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

