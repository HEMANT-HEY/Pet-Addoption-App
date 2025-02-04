import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_adoption_app/view/pet_details_screen.dart';
import 'package:pet_adoption_app/view/pets_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PetsController petsController=Get.put(PetsController());


  List<Map<String, dynamic>> filteredList = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    filteredList = petsController.categoryList;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          bool shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Exit App"),
              content: Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text("Yes"),
                ),
              ],
            ),
          ) ?? false;

          return shouldExit;
        },

        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    offset: Offset(0, 4), // Only bottom shadow
                    blurRadius: 10, // Spread of the shadow
                    spreadRadius: 1, // Size of the shadow
                  ),
                ],
              ),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.teal,
                scrolledUnderElevation: 0,
                elevation: 0,
                title: Text('Pets',style: TextStyle(
                    fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: Colors.white
                ),),
                centerTitle: true,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: GetBuilder<PetsController>(
                builder: (petsController) {
                return Column(
                  children: [
                    Container(
                     margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50, // Background color
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        border: Border.all(color: Colors.grey.shade300), // Border color
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (String query) {
                          List<Map<String, dynamic>> tempList = petsController.categoryList
                              .where((item) => item['title'].toLowerCase().contains(query.toLowerCase()))
                              .toList();

                          setState(() {
                            filteredList = tempList;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search here",
                          border: InputBorder.none, // Removes default border
                          prefixIcon: Icon(Icons.search, color: Colors.grey), // Optional icon
                        ),
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Get.to(PetDetailsScreen(
                            petTitle:filteredList[index]['title'] ,
                            petDetail: filteredList[index]['details'],
                            petImg:filteredList[index]['image'] ,
                            petAge:filteredList[index]['age'] ,
                            petPrice:filteredList[index]['price'] ,
                            petId:filteredList[index]['id'] ,
                            petisAddepted:filteredList[index]['isAdopted']  ,

                          ));
                        },
                        child: Container(
                          margin:EdgeInsets.only(left: 10,right: 10,bottom: 10,top:index==0?10:0),
                          width: width,
                          height: height*0.15,
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex:2,
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: AssetImage('${filteredList[index]['image']}'),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:6,
                                child: Container(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [

                                     Container(
                                       margin:EdgeInsets.only(right: 10),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text('${filteredList[index]['title']}',style: TextStyle(
                                             fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w700,color: Colors.black
                                           ),),

                                           Container(
                                             height: 20,
                                             decoration: BoxDecoration(
                                                 color: Colors.teal,
                                               borderRadius: BorderRadius.circular(5)
                                             ),
                                             child: Center(
                                               child: Text(' ${filteredList[index]['price']} ',style: TextStyle(
                                                   fontSize: 12,fontFamily: 'Poppins',fontWeight: FontWeight.w700,color: Colors.white
                                               ),),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                     SizedBox(height: 5,),
                                     Text('${filteredList[index]['details']}',style: TextStyle(
                                         fontSize: 12,fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: Colors.grey.shade500
                                     ),),
                                     filteredList[index]['isAdopted']==true?
                                     Align(
                                       alignment:Alignment.topRight,
                                       child: Padding(
                                         padding:EdgeInsets.only(right: 10),
                                         child: Container(
                                           height: height*0.02,
                                           width: width*0.25,
                                           decoration: BoxDecoration(
                                               color: Colors.grey,
                                               borderRadius: BorderRadius.circular(11)
                                           ),
                                           child: Center(
                                             child: Text(' Already Adopted ',style: TextStyle(
                                                 fontSize: 8,fontFamily: 'Poppins',fontWeight: FontWeight.w700,color: Colors.white
                                             ),),
                                           ),
                                         ),
                                       ),
                                     ):Container(),
                                   ],
                                 ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
