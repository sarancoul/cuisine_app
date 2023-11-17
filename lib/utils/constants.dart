import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutte_cuisine/pages/ajouterrecette_seconde.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFF1A803);
const Color secondaryColor = Color(0xFFB72C2B);

const Color branc = Color(0x00ffffff);
const Color quatrimecolor = Color(0x00958a8a);

List<DynamicWidgetIngredient> ingredients = [];
List<Ingredient> ingrediantList = [];
String apiImageUrl = "http://localhost:8081/recette/images/";
String apiVideoUrl = "http://localhost:8081/recette/videos/";
