import 'package:flutte_cuisine/Dashbord/widgets/dynamic_wiget.dart';
import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFF1A803);
const Color secondaryColor = Color(0xFFB72C2B);

const Color branc = Color(0x00ffffff);
const Color quatrimecolor = Color(0x00958a8a);

List<DynamicWidgetIngredient> ingredients = [];
List<Ingredient> ingrediantList = [];
String apiUrlLocalhost = "http://localhost:8081/";
String apiUrlIp = "http://192.168.111.217:8081/";

String apiImageUrl = "http://localhost:8081/recette/images/";
String apiVideoUrl = "http://localhost:8081/recette/videos/";

bool dashboard = false;
bool next = false;
