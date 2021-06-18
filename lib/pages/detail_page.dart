import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herewigo/model/post_model.dart';
import 'package:herewigo/services/pref_service.dart';
import 'package:herewigo/services/rtdb_service.dart';
import 'package:herewigo/services/stor_service.dart';
import 'package:image_picker/image_picker.dart';

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

  bool _isLoading = false;

  final picker = ImagePicker();
  File _image;

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    child: _image == null ?
                    Image.asset('assets/images/ic_picture.png') :
                    Image.file(_image),
                  ),
                ),

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
                    hintText: 'Lastname',
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

          _isLoading ? Center(child: CircularProgressIndicator(),) :
              SizedBox.shrink(),
        ],
      ),
    );
  }

  _addPost() async {
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();

    if (firstname.isEmpty || lastname.isEmpty || content.isEmpty || date.isEmpty || _image == null) return;

    setState(() {
      _isLoading = true;
    });

    StoreService.uploadImage(_image).then((image_url) => {
      _apiAddPost(firstname, lastname, content, date, image_url),
    });


  }

  _apiAddPost(String firstname, String lastname, String content, String date, String img_url) async {
    var id = await Prefs.loadUserId();

    RTDBService.addPost(Post(id.toString(), firstname, lastname, content, date, img_url)).then((_) => {
      respAddPost(),
    });
  }

  respAddPost() {
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop({'data' : 'done'});
  }
}
