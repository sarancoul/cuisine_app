import 'package:flutte_cuisine/Service/Ingredient_Service.dart';
import 'package:flutte_cuisine/utils/constants.dart';
import 'package:flutter/material.dart';

class DynamicWidgetIngredient extends StatefulWidget {
  // List ingredients;
  int index;
  DynamicWidgetIngredient({super.key, required this.index});
  int? ingredientId;
  TextEditingController ingreController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  @override
  State<DynamicWidgetIngredient> createState() =>
      _DynamicWidgetIngredientState();
}

class _DynamicWidgetIngredientState extends State<DynamicWidgetIngredient> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      direction: ingredients.isNotEmpty
          ? DismissDirection.startToEnd
          : DismissDirection.none,
      onDismissed: (direction) async {
        if (widget.ingredientId != null) {
          final resul =
              await IngredientService.supprimerIngredient(widget.ingredientId!);
          if (resul == true) {
            print(resul);
            ingredients.removeAt(widget.index);
            setState(() {});
          }
        } else {
          ingredients.removeAt(widget.index);
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          // height: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Icon(Icons.drag_indicator),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: widget.ingreController,
                    decoration: const InputDecoration(
                      hintText: 'Ingrédient',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: widget.prixController,
                    decoration: const InputDecoration(
                      hintText: 'Prix',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              // Expanded(child: TextFormField()),
              //Expanded(child: TextFormField())
            ],
          ),
        ),
      ),
    );
  }
}
