import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseImagePicker extends StatefulWidget {
  final double imageSize;
  StorageReference imageRef;

  FirebaseImagePicker({Key key, @required this.imageRef, this.imageSize: 200});

  @override
  _FirebaseImagePickerState createState() => _FirebaseImagePickerState();
}

class _FirebaseImagePickerState extends State<FirebaseImagePicker> {
  String _imageUrl;
  bool _loading = true;
  String _error;

  @override
  void initState() {
    super.initState();
    updateImage();
  }

  updateImage() async {
    widget.imageRef.getDownloadURL().then((downloadURL) {
      print("IMAGE URL");
      print(downloadURL);
      setState(() {
        _loading = false;
        _imageUrl = downloadURL;
      });
    }).catchError((error) {
      setState(() {
        _loading = false;
        _error = error.toString();
      });
    });
  }

  uploadImage(File imageFile) async {
    setState(() {
      _loading = true;
    });
    await widget.imageRef.putFile(imageFile).onComplete;
    updateImage();
  }

  //Open gallery
  pickImageFromGallery() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sending Message"),
      ));
      return; // No image picked
    }
    uploadImage(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: pickImageFromGallery,
      child: Container(
        width: widget.imageSize,
        height: widget.imageSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: _loading
            ? _loadingIcon()
            : _imageUrl == null
                ? Image.asset("assets/images/place_holder.jpg")
                : CachedNetworkImage(
                    imageUrl: _imageUrl,
                    placeholder: (context, url) => _loadingIcon(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fitWidth,
                  ),
      ),
    );
  }

  Widget _loadingIcon() => Center(child: CircularProgressIndicator());
}
