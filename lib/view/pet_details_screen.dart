
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_adoption_app/view/pets_controller.dart';

import 'full_screen_view.dart';
import 'home_screen.dart';

class PetDetailsScreen extends StatefulWidget {
  var petImg;
  var petTitle;
  var petDetail;
  var petPrice;
  var petAge;
  var petId;
  var petisAddepted;

   PetDetailsScreen({super.key,this.petDetail,this.petImg,this.petTitle,this.petAge,this.petPrice,this.petId,this.petisAddepted});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {


  final ConfettiController _confettiController =
  ConfettiController(duration: Duration(seconds: 1));

  PetsController petsController=Get.put(PetsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('petisAddepted==>'+widget.petisAddepted.toString());
  }
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showAdoptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text('🎉 Adoption Successful!'),
          content: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Positioned(
                    top: -20,
                    child: ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirection: pi / 2, // Fire upwards
                      emissionFrequency: 0.1,
                      numberOfParticles: 12,
                      maxBlastForce: 20,
                      minBlastForce: 5,
                      gravity: 0.4,
                    ),
                  ),
                ),
              ),
              Text("You've now adopted a ${widget.petTitle}."),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
              Get.off(HomeScreen());
              },
              child: Text('Close'),

            ),
          ],
        );
      },
    );

    // Start the confetti animation when the dialog opens
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return Scaffold(
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
            iconTheme: IconThemeData(
            color: Colors.white
            ),
            backgroundColor: Colors.teal,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: Text('${widget.petTitle} Details',style: TextStyle(
                fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: Colors.white
            ),),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            Padding(
              padding:EdgeInsets.only(top: height*0.03),
              child: Hero(
                tag:'${widget.petImg}' ,
                child: GestureDetector(
                  onTap: (){
                    Get.to(FullScreenImage(imagePath: '${widget.petImg}'));
                  },
                  child: Container(
                    width: width,
                    height: height*0.35,
                   decoration: BoxDecoration(
                     color: Colors.red,
                     borderRadius: BorderRadius.circular(12)
                   ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                        child: Image.asset('${widget.petImg}',fit: BoxFit.fill,)),
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.04,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' Age: ${widget.petAge} ',style: TextStyle(
                      fontSize: 14,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color: Colors.black
                  ),),
                  Container(
                    height: 30,
                    width: width*0.3,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text(' Price: ${widget.petPrice} ',style: TextStyle(
                          fontSize: 14,fontFamily: 'Poppins',fontWeight: FontWeight.w600,color: Colors.white
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.01,),
           widget.petisAddepted==true?
            Align(
              alignment:Alignment.topRight,
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
            ):Container(),
            SizedBox(height: height*0.01,),
            Align(
              alignment: Alignment.topLeft,
              child: Text('${widget.petDetail}',style: TextStyle(
                  fontSize: 14,fontFamily: 'Poppins',fontWeight: FontWeight.w500,color: Colors.black
              ),),
            ),
            Spacer(),
            Container(
              height: height*0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:widget.petisAddepted==true?Colors.grey: Colors.teal
                ),
                  onPressed:widget.petisAddepted==true?(){}: (){
                  print('id==>'+widget.petId.toString());
                  petsController.adoptPet(widget.petId);
                    _showAdoptDialog(context);
                  },

                  child: Center(
                    child: Text('Adopt Me',style: TextStyle(
                        fontSize: 14,fontFamily: 'Poppins',fontWeight: FontWeight.w700,color: Colors.white
                    ),),
                  )
              ),
            ),
            SizedBox(height: height*0.04,),
          ],
        ),
      ),
    );
  }
}
