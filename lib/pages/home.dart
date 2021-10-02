import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var markers = HashSet<Marker>(); // Collection
  late BitmapDescriptor img;
  getCustomImg() async {
    img = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/img/online-shop.png');
  }

  @override
  void initState() {
    super.initState();
    //getCustomImg();
  }

  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoords = [];
    polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));

    var polygonSet = Set<Polygon>();
    polygonSet.add(Polygon(
      polygonId: PolygonId('test'),
      points: polygonCoords,
      strokeWidth: 3,
      fillColor: Colors.transparent,
      strokeColor: Colors.red,
    ));

    return polygonSet;
  }

  Set<Circle> circles = Set.from([
    Circle(
      circleId: CircleId('id55'),
      center: LatLng(37.43296265331129, -122.08832357078792),
      radius: 300,
      strokeColor: Colors.black,
      strokeWidth: 1,
    )
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoogleMap'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            circles: circles,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(37.43296265331129, -122.08832357078792),
                zoom: 14),
            onMapCreated: (controller) {
              setState(() {
                markers.add(
                  Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(37.43296265331129, -122.08832357078792),
                    infoWindow: InfoWindow(
                        title: 'Here your title again and again',
                        snippet:
                            'Here your description about your marker location on this map'),
                    onTap: () {
//Do action here
                    },
                    //  icon: img,
                  ),
                );
              });
            },
            markers: markers,
            polygons: myPolygon(),
          ),
          Container(
            // width: double.infinity,
            height: 100,
            child: Image.asset('assets/img/online-shop.png'),
            alignment: Alignment.topCenter,
          ),
          Container(
            // width: double.infinity,
            // height: 100,
            child: Text('Your Title Here'),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }
}
