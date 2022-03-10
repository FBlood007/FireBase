import 'package:flutter/material.dart';

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
                  onPressed: () {
                    DataBase.insertData(
                      emailController.text,
                      passController.text,
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
              //MaterialButton(onPressed: () {}, child: Text('Delete')),
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
                    onTap: () {
                      setState(() {
                        emailController.text = DataBase.data[index]['email'];
                        passController.text = DataBase.data[index]['pass'];
                        selectedDataKey = DataBase.data[index]['key'];
                      });
                    },
                    title: Text(
                      DataBase.data[index]['email'],
                      style:const TextStyle(color: Colors.red),
                    ),
                    subtitle: Text(DataBase.data[index]['pass']),
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
