import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function.dart';
import 'displaySwimmingList.dart';

class swimming_location_screen extends StatefulWidget {
  static String routeName = '/swimming_Location_Screen';


  @override
  State<swimming_location_screen> createState() =>
      _swimming_location_screenState();
}



class _swimming_location_screenState extends State<swimming_location_screen> {
  TextEditingController searchController = TextEditingController();
  bool isDescending = false;


  @override
  Widget build(BuildContext context) {

    search_function storeListfirst = Provider.of<search_function>(context);

    Widget searchfield(){
      return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.cyan,
          border: Border.all(
            width: 2,
            color: Colors.black87,
          )
        ),
        child: TextField(
          controller: searchController,
          onChanged: (value){
            setState((){
              storeListfirst.searchQuery = value.toLowerCase(); //Calls the searchString in movieshowList
            });
          },
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: Icon(Icons.search),
          ),
        ),
      );
    }


    Widget displaytest(isDescending){
      return Container(
                height: 600,
                child: display_SearchResults(
                  storeListfirst.getSearchResults(),this.isDescending, searchController: searchController,
                ),
      );
    }



    Widget SortbyAlphabetically() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchfield(),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.cyan,
                border: Border.all(
                  width: 2,
                  color: Colors.black87,
                ),
            ),
            child: TextButton.icon(
              icon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.compare_arrows, size: 28, color: Colors.white),
              ),
              label: Text(isDescending ? 'Descending By Alphabetically ' : 'Ascending By Alphabetically ',
                  style: TextStyle(fontSize: 20, color: Colors.white)
              ),
              onPressed: () => setState(()
              => isDescending = !isDescending
              ),
            ),
          ),
          Expanded(child: displaytest(this.isDescending))
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Swimming Pool'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:  Alignment.bottomRight,
                  colors: [
                    Color(0xFF135A4F),
                    Color(0xFF174A63),
                  ]
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,

        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:  Alignment.bottomRight,
                  colors: [
                    Color(0xFF256F62),
                    Color(0xFF337095),
                  ]
              ),
            ),
            child:Stack(
              children:[
                SortbyAlphabetically()
              ],
            )
        )
    );
  }
}


