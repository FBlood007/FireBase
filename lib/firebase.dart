import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'database.dart';

class FireBase extends StatefulWidget {
  const FireBase({Key? key}) : super(key: key);

  @override
  State<FireBase> createState() => _FireBaseState();
}

class _FireBaseState extends State<FireBase> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  String selectedDataKey = '';
  FirebaseStorage storage = FirebaseStorage.instance;
  String imageURL = '';

  uploadImage() async {

    ///Pick image from Gallery
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    ///Create Folder and File
    Reference reference = storage.ref().child("images/${DateTime.now().toString()}");

    ///Upload Image
    UploadTask uploadTask = reference.putFile(File(image!.path));

    ///Set Url
    await(await uploadTask).ref.getDownloadURL().then((value) {
      print('===$value');
      imageURL = value;
    });

    ///Insert Data to Realtime Firebase
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Fire Base',
                style:TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),
              Container(
                width: 300,
                padding:const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFe0e0e0),
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailController,
                  style:const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                padding:const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFe0e0e0),
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: passController,
                  style:const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10,),
              MaterialButton(
                  color: Colors.blue,
                  onPressed:(){
                    uploadImage();
                  },
                child:const Text('Upload Image',style: TextStyle(color: Colors.white),),
              ),
              MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    DataBase.insertData(
                      emailController.text,
                      passController.text,
                      imageURL,
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child:const Text('Insert',style: TextStyle(color: Colors.white),)),
              MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    DataBase.updateDate(
                      emailController.text,
                      passController.text,
                      selectedDataKey,
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child:const Text('Update',style: TextStyle(color: Colors.white),)),
              MaterialButton(
                color: Colors.blue,
                  onPressed: () {
                    DataBase.selectData().then((value) {
                      setState(() {});
                    });
                  },
                padding:const EdgeInsets.all(10),
                  child:const Text('Select',style: TextStyle(color: Colors.white),),),
              Expanded(
                child: ListView.builder(
                  itemCount: DataBase.data.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(DataBase.data[index]['image']),),
                    onTap: () {
                      setState(() {
                        emailController.text = DataBase.data[index]['email'];
                        passController.text = DataBase.data[index]['pass'];
                        selectedDataKey = DataBase.data[index]['key'];
                      });
                    },
                    title: Text('Email : '+DataBase.data[index]['email'],
                      style:const TextStyle(color: Colors.red),
                    ),
                    subtitle: Text('Pass : '+DataBase.data[index]['pass']),
                    trailing: IconButton(
                      onPressed: () {
                        DataBase.deleteData(DataBase.data[index]['key']);
                      },
                      icon:const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
