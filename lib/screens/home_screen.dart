import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/meal_service.dart';
import '../services/favorites_service.dart';
import 'meal_detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MealService _mealService = MealService();
  List<dynamic> _meals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMeals(); // Yemekleri getir
  }

  void _fetchMeals() async {
    setState(() => _isLoading = true);
    try {
      var meals = await _mealService.fetchMealsByCategory('Seafood'); // Kategoriye göre yemekleri getir
      setState(() {
        _meals = meals ?? [];
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching meals: $e');
      setState(() => _isLoading = false);
    }
  }

  void _navigateToMealDetail(String id) async {
    setState(() => _isLoading = true);
    try {
      var mealDetails = await _mealService.fetchMealDetails(id); // Yemek detaylarını getir
      setState(() => _isLoading = false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealDetailScreen(meal: mealDetails),
        ),
      );
    } catch (e) {
      print('Error fetching meal details: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Finder'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(), // Favoriler ekranına geçiş
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: _meals[index]['strMealThumb'] != null
                  ? Image.network(
                _meals[index]['strMealThumb'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : null,
              title: Text(_meals[index]['strMeal']),
              trailing: Builder(
                builder: (context) {
                  final favoritesService = Provider.of<FavoritesService>(context);
                  return IconButton(
                    icon: Icon(
                      favoritesService.isFavorite(_meals[index]['idMeal'])
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      setState(() {
                        if (favoritesService.isFavorite(_meals[index]['idMeal'])) {
                          favoritesService.removeFromFavorites(_meals[index]['idMeal']);
                        } else {
                          favoritesService.addToFavorites(_meals[index]['idMeal']);
                        }
                      });
                    },
                  );
                },
              ),
              onTap: () {
                _navigateToMealDetail(_meals[index]['idMeal']); // Yemek detaylarına geçiş
              },
            ),
          );
        },
      ),
    );
  }
}



