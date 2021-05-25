import 'dart:io';
import 'main.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  ProgressDialog pr;
  double screenHeight, screenWidth;
  String pathAsset = 'assets/images/image.png';
  File _image;
  bool _visible = true;
  TextEditingController _prnameController = new TextEditingController();
  TextEditingController _prtypeController = new TextEditingController();
  TextEditingController _prpriceController = new TextEditingController();
  TextEditingController _prqtyController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print("KB" + visible.toString());
        if (visible) {
          _visible = false;
        } else {
          _visible = true;
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Center(
        child: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  GestureDetector(
                    onTap: () => {_onPictureSelectionDialog()},
                    child: Container(
                        height: screenHeight / 3.5,
                        width: screenWidth / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image == null
                                ? AssetImage(pathAsset)
                                : FileImage(_image),
                            fit: BoxFit.scaleDown,
                          ),
                        )),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _prnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Enter Product Name',
                        hintText: 'Name',
                      ),
                      onChanged: (_prnameController) {
                        if (_prnameController.isEmpty) {
                          setState(() {});
                        }
                        setState(() {});
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _prtypeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Enter Product Type',
                        hintText: 'Type',
                      ),
                      onChanged: (_prtypeController) {
                        if (_prtypeController.isEmpty) {
                          setState(() {});
                        }
                        setState(() {});
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _prpriceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Enter Product Price (RM)',
                        hintText: 'Price (RM)',
                      ),
                      onChanged: (_prpriceController) {
                        if (_prpriceController.isEmpty) {
                          setState(() {});
                        }
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _prqtyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Enter Quantity (units)',
                        hintText: 'Quantity (units)',
                      ),
                      onChanged: (_prqtyController) {
                        if (_prqtyController.isEmpty) {
                          setState(() {});
                        }
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    child: Text(""),
                    visible: _visible,
                  ),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      _addProductDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[700],
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ),
                ],
              ))),
        ),
      ),
    );
  }

  _onPictureSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: new Container(
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Select From:",
                        style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: MaterialButton(
                        color: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        minWidth: 100,
                        height: 100,
                        child: Column(children: <Widget>[
                          Icon(FontAwesomeIcons.camera,
                              color: Colors.white, size: 50),
                          SizedBox(height: 10),
                          Text('Camera',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ))
                        ]),
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseCamera()},
                      )),
                      SizedBox(width: 20),
                      Flexible(
                          child: MaterialButton(
                        color: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        minWidth: 100,
                        height: 100,
                        child: Column(children: <Widget>[
                          Icon(FontAwesomeIcons.archive,
                              color: Colors.white, size: 50),
                          SizedBox(height: 10),
                          Text('Gallery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ))
                        ]),
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseGallery()},
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  Future _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  Future _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.orange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _addProductDialog() {
    String _prname = _prnameController.text.toString();
    String _prtype = _prtypeController.text.toString();
    String _prprice = _prpriceController.text.toString();
    String _prqty = _prqtyController.text.toString();

    if (_image == null ||
        _prname.isEmpty ||
        _prtype.isEmpty ||
        _prprice.isEmpty ||
        _prqty.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Are your sure you want to submit?"),
            actions: [
              TextButton(
                child: Text("Submit"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addProduct(_prname, _prtype, _prprice, _prqty);
                },
              ),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _addProduct(
      String prname, String prtype, String prprice, String prqty) async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Posting...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();
    String base64Image = base64Encode(_image.readAsBytesSync());
    String prname = _prnameController.text.toString();
    String prtype = _prtypeController.text.toString();
    String prprice = _prpriceController.text.toString();
    String prqty = _prqtyController.text.toString();
    http.post(
        Uri.parse("https://pyong27.com/s271147/myshop/php/newproduct.php"),
        body: {
          "prname": prname,
          "prtype": prtype,
          "prprice": prprice,
          "prqty": prqty,
          "encoded_string": base64Image
        }).then((response) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      print(response.body);
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Product added successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _image = null;
          _prnameController.text = "";
          _prtypeController.text = "";
          _prpriceController.text = "";
          _prqtyController.text = "";
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => MyApp()));
      } else {
        Fluttertoast.showToast(
            msg: "Product failed to add.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
