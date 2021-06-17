import 'package:flutter/material.dart';
import 'package:herewigo/model/post_model.dart';
import 'package:herewigo/services/pref_service.dart';
import 'package:herewigo/services/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = 'detail_page';

  const DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final contentController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            // TextField : Firstname
            TextField(
              controller: firstnameController,
              decoration: InputDecoration(
                hintText: 'Firstname',
              ),
            ),

            SizedBox(height: 15,),

            // TextField : Lastname
            TextField(
              controller: lastnameController,
              decoration: InputDecoration(
                hintText: 'Lasttname',
              ),
            ),

            SizedBox(height: 15,),

            // TextField : Content
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                hintText: 'Content',
              ),
            ),

            SizedBox(height: 15,),

            // TextField : Date
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                hintText: 'Date',
              ),
            ),

            SizedBox(height: 15,),

            FlatButton(
              height: 45,
              minWidth: double.infinity,
              color: Colors.red,
              child: Text('Add', style: TextStyle(color: Colors.white),),
              onPressed: _addPost,
            ),
          ],
        ),
      ),
    );
  }

  _addPost() async {
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();

    var id = await Prefs.loadUserId();
    
    RTDBService.addPost(Post(id.toString(), firstname, lastname, content, date)).then((_) => {
      respAddPost(),
    });
  }

  respAddPost() {
    Navigator.of(context).pop({'data' : 'done'});
  }
}
