import 'package:flutte_cuisine/Model/Ingredient_Model.dart';
import 'package:http/http.dart' as http;
class IngredientService {
  final String baseUrl;
  static const apiUrl = 'http://localhost:8081/ingredient';
  IngredientService(this.baseUrl);


  static Future<bool> supprimerIngredient(int id) async {
    print("Bonjour tout le monde");
    final response = await http.delete(Uri.parse('$apiUrl/delete/$id'));

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("la reponse est bonne");
      return true;
      print('Ingrédient supprimé avec succès');
    } else if (response.statusCode == 404) {
      return false;
      print('ingredient non trouvé');
    } else {
      throw Exception(
          'Impossible de supprimer la recette : ${response.statusCode}');
    }
  }
}
