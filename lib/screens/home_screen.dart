import 'package:cowin_app/http/appHttp.dart';
import 'package:cowin_app/utils/home_page_controller.dart';
import 'package:cowin_app/widgets/appBottomNavigation.dart';
import 'package:cowin_app/widgets/app_form.dart';
import 'package:cowin_app/widgets/available_slots.dart';
import 'package:cowin_app/widgets/members.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final HomePageController myController = HomePageController();

  final TextEditingController _photoIdNumberController =
      TextEditingController();
  List _idTypes = [];
  List _genders = [];

  String _selectedIdType;
  String _selectedGender;

  int _selectedPageIndex = 0;

  void _selectPage(int page) {
    setState(() {
      _selectedPageIndex = page;
    });
  }

  _selectGender(val, changeState) {
    changeState(() {
      _selectedGender = val;
    });
  }

  @override
  void initState() {
    initData().then((data) => data);
    super.initState();
  }

  Future<void> initData() async {
    final idTypes = await getIdTypes();
    final genders = await getGender();
    setState(() {
      _idTypes = idTypes;
      _genders = genders;
    });
  }

  _onSelctIdType(val, changeState) {
    changeState(() {
      _selectedIdType = val;
    });
  }

  _onSubmit(BuildContext dialogCtx) async {
    if (_formKey.currentState.validate()) {
      try {
        String name = _nameController.text;
        int genderId = int.parse(_selectedGender);
        int photoIdType = int.parse(_selectedIdType);
        String photoIdNumber = _photoIdNumberController.text;
        String birthYear = _birthDateController.text;
        await registerBenificiary(
          name: name,
          genderId: genderId,
          photoIdType: photoIdType,
          photoIdNumber: photoIdNumber,
          birthYear: birthYear,
        );
        myController.getMemmbersSub();
        Navigator.pop(dialogCtx);
      } catch (e) {
        print(e);
      }
    }
  }

  _onAddMember() {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setstate) {
          return AppForm(
            birthDateController: _birthDateController,
            formKey: _formKey,
            selectedPhotoIdType: _selectedIdType,
            onChangePhotoIdType: (val) => _onSelctIdType(val, setstate),
            photoIdTypes: _idTypes,
            photoIdNumber: _photoIdNumberController,
            nameController: _nameController,
            onGenderChange: (val) => _selectGender(val, setstate),
            genders: _genders,
            selectedGender: _selectedGender,
            formSubmit: _onSubmit,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedPageIndex == 0
          ? AppBar(
              title: Text(
              'Members',
            ))
          : null,
      body: Container(
        child: _selectedPageIndex == 0
            ? Members(
                controller: myController,
                key: ValueKey('members-view'),
              )
            : AvailableSlots(key: ValueKey('available-slot-view')),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        isLoggedIn: true,
        selectPage: _selectPage,
        selectedPageIndex: _selectedPageIndex,
      ),
      floatingActionButton: _idTypes.isNotEmpty && _genders.isNotEmpty
          ? FloatingActionButton(
              onPressed: _onAddMember,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
