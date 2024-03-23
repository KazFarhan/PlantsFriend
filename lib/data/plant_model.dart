import 'package:my_new_plants/data/plant_data.dart';

class Plants {
  final int id;
  final String name;
  final String imagePath;
  final String category;
  final String description;
  final String water;
  final String sunrays;
  final String soil_PH;
  final String temperature;
  final double price;
  final bool isFavorit;
  final String details1;
  final String detailsS2;
  final String detailsS3;
  final String details4;
  final String details5;
  final String detailsS6;
  final String detailsS7;
  final String details8;
  final String decoration1;
  final String decoration2;
  final String decoration3;
  final String decoration4;
  final String decoration5;
  final String waterdet1;
  final String waterdet2;
  final String sunlight1;
  final String sunlight2;
  final String temper1;
  final String temper2;
  final String seas1;
  final String seas2;
  final String Diseases;
  final String Diseases1;
  final String Diseases2;
  final String Diseases3;
  final String Diseases4;

  Plants({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.category,
    required this.water,
    required this.sunrays,
    required this.soil_PH,
    required this.temperature,
    required this.description,
    required this.price,
    required this.isFavorit,
    required this.details1,
    required this.detailsS2,
    required this.detailsS3,
    required this.details4,
    required this.details5,
    required this.detailsS6,
    required this.detailsS7,
    required this.details8,
    required this.decoration1,
    required this.decoration2,
    required this.decoration3,
    required this.decoration4,
    required this.decoration5,
    required this.waterdet1,
    required this.waterdet2,
    required this.sunlight1,
    required this.sunlight2,
    required this.temper1,
    required this.temper2,
    required this.seas1,
    required this.seas2,
    required this.Diseases,
    required this.Diseases1,
    required this.Diseases2,
    required this.Diseases3,
    required this.Diseases4,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'imagePath': imagePath,
    };
  }


  
}




