import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  List latLn = [
    {
      "lat" : 23.730525,
      "lng" : 90.416452
    },
    {
      "lat" : 23.730250,
      "lng" : 90.416238
    },

    {
      "lat" : 23.734061,
      "lng" : 90.413491
    },
    {
      "lat" : 23.725614,
      "lng" : 90.417611
    },
    {
      "lat" : 23.735190,
      "lng" : 90.420277
    },
    {
      "lat" : 90.422853,
      "lng" : 23.731509
    },

  ];

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.733079, 90.416796),
    zoom: 14.4746,
  );



  LatLng initialLocation = const LatLng(37.422131, -122.084801);


  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor othersLocationIcon = BitmapDescriptor.defaultMarker;

  void currentLocation() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/current-location.png")
        .then(
          (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  void othersLocation() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/others-location.png")
        .then(
          (icon) {
        setState(() {
          othersLocationIcon = icon;
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocation();
    othersLocation();
  }

  List cat = [
    "Video Editor",
    "Photographer",
    "Cinematographer",
    "Video Editor",
    "Photographer",
    "Cinematographer",
  ];
  List selectedCat = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SizedBox(
          height: 50,
          width: size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cat.length,
            itemBuilder: (_, index){
              return InkWell(
                onTap: (){
                  setState(() {
                    selectedCat.clear();
                    selectedCat.add(cat[index]);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: selectedCat.contains(cat[index]) ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(
                    child: Text("${cat[index]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: selectedCat.contains(cat[index]) ? Colors.white : Colors.black
                      ),
                    ),
                  ),
                ),
              );
              },
          ),
        ),
        leading: IconButton(
          onPressed: (){},
          color: Colors.black,
          icon: Icon(Icons.arrow_back),

        ),
      ),
      body:GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        markers: {
          Marker(
            markerId: const MarkerId("marker133"),
            position: const LatLng(23.727009,90.4219455),
            draggable: true,
            onDragEnd: (value) {
              // value is the new position
            },
            icon: markerIcon,
          ),
          for(var i=0; i<latLn.length; i++)
            Marker(
                markerId:  MarkerId("marker$i"),
                position:  LatLng(latLn[i]["lat"], latLn[i]["lng"]),
                icon: othersLocationIcon,
                draggable: true,
                onDragEnd: (value) {
                  // value is the new position
                },
                onTap: ()=>userProfile()
            ),
        },

        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

    );
  }

  userProfile()async{
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png", height: 70, width: 70, fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nayon Talukder",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Center(
                                  child: Text("Photographer",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Center(
                                  child: Text("Photographer",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    )
                  ],
                ),
                SizedBox(height: 15,),
                InkWell(
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(
                      child: Text("View Profile",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                InkWell(
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(
                      child: Text("Map Direction",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

}
