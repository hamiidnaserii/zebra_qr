
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ech_flutter/src/MainSrc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';


import '../MyWidgets.dart';

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyFadeTest createState() => _MyFadeTest();

}

class _MyFadeTest extends State<MyFadeTest>  {
  TextEditingController UrlController = new TextEditingController();
  TextEditingController SizeController = new TextEditingController();
  String url,size,urlQr,errorUrl;

  void initState(){
    super.initState();
    url="";
    size="";
    urlQr="";
    errorUrl="";
  }




  void showDialogQr(context,url,site/*{double W =double.infinity,double H =double.infinity}*/) {

    // final double dialogHeight = W / 2;
    // final double dialogWidth = H / 2;
    final double dialogWidth = 400;
    final double dialogHeight = 500;

    Widget _MyDialog = Dialog(
      backgroundColor:Colors.white,
      child:Container(
        width:dialogWidth,
        height:dialogHeight,
        child:Column(
          children: [
            Container(
              width:dialogWidth,
              color:Colors.white,
              padding:EdgeInsets.symmetric(horizontal:30),
              height:dialogWidth,
              child:Image.network("$url",fit:BoxFit.fitWidth),
            ),
            RaisedButton(onPressed:_Download,child:Row(children: [Icon(Icons.download_rounded,color:Colors.white,),Text("Download")],),color:Colors.green,textColor:Colors.white),
            Expanded(
                child:Center(
                  child:Text("Your URL : " + site),
                )
            )

          ],
        ),
      ),
    );
    showDialog(context: context,builder:(context)=>_MyDialog);

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var key_scaffoldKey;




    return Scaffold(
      key: key_scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar( // Here we create one to set status bar color
            backgroundColor: MyColors.primary_card, // Set any color of status bar you want; or it defaults to your theme's primary color
          )
      ),
      body: SafeArea(
          child:SingleChildScrollView(
            child:Stack(
              children: [
                new CustomPaint(
                  painter:
                  new CircleGraphWidget(width, height, MyColors.primary_card),
                  size: Size(width, width),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: width / 2,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Image.asset(
                                'assets/images/ic_launcher.png',
                                width: 100,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "zebraQr",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("FREE QR CODE GENERATOR",
                              style:
                              TextStyle(fontSize: 14, color: MyColors.text_gray)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          input(context,"Your URL",Icon(Icons.link),"",UrlController,errorUrl??"",false),
                          input(context,"Size Qr",Icon(Icons.zoom_out_map_rounded),"defult:250px*250px",SizeController,"",true),
                          Container(
                            padding:EdgeInsets.symmetric(vertical:15),
                            child:RaisedButton(onPressed:_GenerateCode,child:Text("Create QR Code"),color:Colors.blue,textColor:Colors.white,),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }






  void _GenerateCode() {

      setState(() {
        url=UrlController.text;
        size=SizeController.text;
        if(size.isEmpty){
          urlQr = "http://api.qrserver.com/v1/create-qr-code/?data="+url;
        }else{
          urlQr = "http://api.qrserver.com/v1/create-qr-code/?data="+url+"/&size="+size+"x"+size;
        }
        if(url.isEmpty){
          errorUrl ="Please enter your desired link";
        }else{
          showDialogQr(context,urlQr,url);
        }
      });




  }

  _requestPermission() async {

     Map<Permission, PermissionStatus> statuses = await [
       Permission.storage,
     ].request();

  }





  void _Download() async {

    _requestPermission();

    var status = await Permission.storage.status;

    if(status.isGranted){
      _save();
    }


  }
  _save() async {
    var response = await Dio().get(urlQr,
        options: Options(responseType: ResponseType.bytes));
    var rng = new Random();

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: url.toString() +"-"+ rng.nextInt(10).toString());
    if(result['isSuccess']){
      _toastInfo("It was successful");
    }else{
      _toastInfo("Was unsuccessful");
    }

  }
  _toastInfo(String info) {
      Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }
}