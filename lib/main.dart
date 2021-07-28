import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Myapp(),
    ));
String x;
var str;
var op;
var bdy;
var ipad;

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      const url = 'https://access.redhat.com/articles/1189123';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    web(cmd, ip) async {
      var url = 'http://192.168.43.85/cgi-bin/web.py?cmd=$cmd';
      var response = await http.get(url);
      setState(
        () {
          bdy = response.body;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'RHEL-Mobile',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Container(
            child: TextField(
              onChanged: (str) => ipad = str,
              decoration: InputDecoration(
                hintText: 'Enter the commmand',
                enabled: true,
                icon: Icon(Icons.computer),
              ),
              cursorColor: Colors.white,
            ),
          ),
          IconButton(icon: Icon(Icons.help), onPressed: _launchURL),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Container(
                    width: double.infinity,

                    height: MediaQuery.of(context).size.height * .20,

                    color: Colors.black,

                    //  alignment: Alignment.topCenter,

                    child: Image.asset(
                      'assets/images/redhat-docker.png',
                      fit: BoxFit.fitHeight,
                    ),
                  )
                : Container(),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        onChanged: (str) => x = str,
                        decoration: InputDecoration(
                          hintText: 'Enter the commmand',
                          enabled: true,
                          icon: Icon(Icons.computer),
                        ),
                        cursorColor: Colors.white,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        await web(x, ipad);
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      splashColor: Colors.indigo,
                      child: Text('Submit'),
                    ),
                    Container(
                      //padding: EdgeInsets.all(20),

                      width: MediaQuery.of(context).size.width,

                      height: MediaQuery.of(context).size.height,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 10),

                            // padding: EdgeInsets.only(right: 20),

                            width: MediaQuery.of(context).size.width,

                            height: MediaQuery.of(context).size.height * .04,

                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),

                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/images/logo.png',

                                  //scale: 40.00,

                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Terminal',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '[root@localhost rhel8]# ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                x ?? " ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            bdy ?? " ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton.extended(onPressed: null, label: null),
      backgroundColor: Colors.black,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
    );
  }
}
