import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_plants/data/plant_data.dart';
import 'package:my_new_plants/widgets/bottom_nav.dart';
import '../data/plant_model.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget{
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Plants> display_list = List.from(plants);
  bool isSearchEmpty = true;

  void updateList(String value){
    setState(() {
      display_list = plants.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
      isSearchEmpty = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>BottomNavBar()));
            }, icon: Icon(Icons.arrow_back)),

            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: TextField(
                onChanged: (value)=>updateList(value),
                style: GoogleFonts.robotoSerif(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search Plant',
                    prefixIcon: Icon(Icons.search,size: 30),
                    prefixIconColor: Colors.grey
                ),
              ),
            ),
            SizedBox(height: 20),
            if (!isSearchEmpty)
              Expanded(
                child:ListView.builder(
                  itemCount: display_list.length,
                  itemBuilder: (context, index)=> GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>DetailsPage(plant: display_list[index])));
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(display_list[index].name,
                        style: GoogleFonts.openSans(
                          color: Colors.grey,
                        ),
                      ),
                      subtitle: Text(display_list[index].category,
                        style: GoogleFonts.openSans(
                          color: Colors.grey,
                        ),
                      ),
                      leading: Image.asset(display_list[index].imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
