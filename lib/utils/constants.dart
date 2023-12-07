import 'package:flutte_cuisine/Dashbord/widgets/dynamic_wiget.dart';
import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFF1A803);
const Color secondaryColor = Color(0xFFB72C2B);

const Color branc = Color(0x00ffffff);
const Color quatrimecolor = Color(0x00958a8a);

List<DynamicWidgetIngredient> ingredients = [];
List<Ingredient> ingrediantList = [];
String apiUrl = kIsWeb ? "http://localhost:8081/" : "http://172.20.10.13:8081/";
String apiUrlLocalhost = apiUrl; // "http://localhost:8081/";
String apiUrlIp = apiUrl; //"http://192.168.42.113:8081/";

String apiImageUrl = "${apiUrl}recette/images/";
String apiVideoUrl = "${apiUrl}recette/videos/";

bool dashboard = false;
bool next = false;
