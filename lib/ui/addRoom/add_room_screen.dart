import 'package:chat_app/base/base.dart';
import 'package:chat_app/model/room_category.dart';
import 'package:chat_app/ui/addRoom/add_room_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'Add Room Screen';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  List<RoomCategory> allCats = RoomCategory.getRoomCategories();
  late RoomCategory selectedRoomCategory;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRoomCategory = allCats[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background_pattern.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('Chat App'),
            ),
            body: Card(
              margin: EdgeInsets.all(24),
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create New Room',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/add_room_image.png'),
                      TextFormField(
                        controller: titleController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Room Name'),
                      ),
                      DropdownButton<RoomCategory>(
                          value: selectedRoomCategory,
                          items: allCats.map((cat) {
                            return DropdownMenuItem<RoomCategory>(
                                value: cat,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/${cat.imageName}',
                                        width: 48,
                                        height: 48,
                                      ),
                                    ),
                                    Text(
                                      cat.name,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (item) {
                            if (item == null) return;
                            selectedRoomCategory = item;
                            setState(() {});
                          }),
                      TextFormField(
                        controller: descController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Descreption';
                          }
                          return null;
                        },
                        minLines: 1,
                        maxLines: 3,
                        decoration:
                            InputDecoration(labelText: 'Room Descreption'),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24)))),
                          onPressed: () {
                            submit();
                          },
                          child: Text('Create'))
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void submit() {
    if (formKey.currentState?.validate() == false) return;
    viewModel.addRoom(
        titleController.text, descController.text, selectedRoomCategory.id);
  }

  @override
  void goBack() {
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: 'Room Created Successfuly',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
