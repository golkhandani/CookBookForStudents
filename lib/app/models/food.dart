import 'package:flutter/material.dart';

class Ingredient {
  Ingredient({
    required this.title,
    required this.image,
    this.color,
  });

  String title;
  String image;
  Color? color = Colors.amber;
}

class Food {
  Food({
    required this.title,
    required this.image,
    required this.preperationTime,
    required this.cookingTime,
    required this.cost,
    required this.ingredients,
    this.color,
  });

  String title;
  String image;
  String preperationTime;
  String cookingTime;
  int cost;
  List<Ingredient> ingredients;
  Color? color = Colors.amber;
}

List<Food> foods = [
  Food(
    title: "Food 1",
    image: "https://unsplash.com/photos/-YHSwy6uqvk/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 2",
    image: "https://unsplash.com/photos/w6ftFbPCs9I/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 3",
    image: "https://unsplash.com/photos/eeqbbemH9-c/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 1",
    image: "https://unsplash.com/photos/-YHSwy6uqvk/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 2",
    image: "https://unsplash.com/photos/w6ftFbPCs9I/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 3",
    image: "https://unsplash.com/photos/eeqbbemH9-c/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 1",
    image: "https://unsplash.com/photos/-YHSwy6uqvk/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 2",
    image: "https://unsplash.com/photos/w6ftFbPCs9I/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 3",
    image: "https://unsplash.com/photos/eeqbbemH9-c/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 1",
    image: "https://unsplash.com/photos/-YHSwy6uqvk/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 2",
    image: "https://unsplash.com/photos/w6ftFbPCs9I/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
  Food(
    title: "Food 3",
    image: "https://unsplash.com/photos/eeqbbemH9-c/download?force=true&w=1920",
    preperationTime: "10 minutes",
    cookingTime: "20 minutes",
    cost: 1,
    ingredients: [
      Ingredient(
        title: "Ingredient 1",
        image: "potato.png",
      )
    ],
  ),
];
