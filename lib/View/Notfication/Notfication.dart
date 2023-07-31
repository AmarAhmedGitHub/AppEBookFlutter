import 'package:flutter/material.dart';

class UserNotification extends StatefulWidget {
  final List<dynamic>? notifications;
  UserNotification({Key? key, this.notifications}) : super(key: key);

  @override
  State<UserNotification> createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          widget.notifications!.length != 0 ? 
          ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.notifications!.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  
                  itemBuilder: (BuildContext context, int index) {
                    //Order order = controller.order[index];
                    // print(post);
                    return Container(
                      height: 100,
                      //width: 100,
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Image.asset("images/books_pile.PNG"),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  //alignment: Alignment.topRight,
                                  height: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Text('${widget.notifications![index]['data']['message']}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.w800
                                                ),
                                            textAlign: TextAlign.start),
                                      ),
                                     ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }) 
          
          : Center(
            
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Image.asset('images/empty.PNG'),
            ],
          ))
        ],
      ),
    );
  }
}
