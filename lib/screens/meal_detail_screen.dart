import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  final Map<String, dynamic> meal;

  MealDetailScreen({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal['strMeal']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal['strMealThumb']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal['strMeal'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ingredients:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                _buildIngredients(meal),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                meal['strInstructions'],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildIngredients(Map<String, dynamic> meal) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String ingredient = meal['strIngredient$i'];
      String measure = meal['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add('$ingredient - $measure');
      }
    }
    return ingredients.join('\n');
  }
}
