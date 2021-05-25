import 'dart:convert';
import 'package:flutter/material.dart';
import 'newproduct.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(
      title: "My Shop",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double screenHeight, screenWidth;
  List _prlist;
  String _titlecenter = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: Center(
        child: Column(children: [
          _prlist == null
              ? Flexible(
                  child: Center(child: Text(_titlecenter)),
                )
              : Flexible(
                  child: Center(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (screenWidth / screenHeight) / 0.8,
                    children: List.generate(_prlist.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(3),
                          child: Card(
                              child: SingleChildScrollView(
                                  child: Column(children: [
                            SizedBox(height: 25),
                            Container(
                              height: screenHeight / 4.5,
                              width: screenWidth / 3,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://pyong27.com/s271147/myshop/images/${_prlist[index]['prid']}.png",
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    new Transform.scale(
                                        scale: 0.5,
                                        child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => new Icon(
                                  Icons.broken_image,
                                  size: screenWidth / 3,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Text("Name: " + _prlist[index]['prname']),
                            Text("Type: " + _prlist[index]['prtype']),
                            Text("Price: RM " + _prlist[index]['prprice']),
                            Text("Quantity: " +
                                _prlist[index]['prqty'] +
                                " units"),
                          ]))));
                    }),
                  ),
                )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewProduct()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {},
            ),
            Container(
              height: 65,
              width: 0.1,
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.bell),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.user),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _loadProducts() {
    http.post(
        Uri.parse("https://pyong27.com/s271147/myshop/php/loadproducts.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No Products";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _prlist = jsondata["products"];
        setState(() {});
        print(_prlist);
      }
    });
  }
}
