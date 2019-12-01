import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet suscipit lorem. Morbi suscipit ex orci, ac feugiat ligula hendrerit sit amet. Quisque lorem libero, viverra in risus a, malesuada blandit metus. Sed pharetra consequat arcu, nec luctus elit aliquet sed. Donec accumsan, massa a pellentesque sagittis, velit ipsum ultricies elit, eu aliquam tellus nisl vel lectus. Pellentesque volutpat tincidunt dignissim. Nunc tempor faucibus lectus luctus scelerisque. Nullam id feugiat ex. Cras ante lectus, mollis non aliquet vitae, porttitor sed mauris. Pellentesque non accumsan orci, quis sodales nibh. Suspendisse gravida dignissim ante vitae pulvinar. Vestibulum quis nulla vehicula, elementum mauris non, vestibulum dui. Duis at elementum nisl. Maecenas leo ipsum, mattis eu dui eget, volutpat rutrum diam. Nunc egestas urna magna, vitae pharetra eros fringilla et. Donec laoreet egestas posuere",
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Press Start 2P',
                      color: Colors.white,
                      fontSize: 10),
                ),
                SizedBox(height: 30),
                FlatButton(
                  child: Text('Return',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Press Start 2P')),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
