import 'package:flutter/material.dart';

class AppForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String selectedPhotoIdType;
  final Function onChangePhotoIdType;
  final List photoIdTypes;
  final TextEditingController photoIdNumber;
  final TextEditingController nameController;
  final TextEditingController birthDateController;
  final Function onGenderChange;
  final List genders;
  final String selectedGender;
  final Function formSubmit;

  AppForm({
    @required this.formKey,
    @required this.selectedPhotoIdType,
    @required this.onChangePhotoIdType,
    @required this.photoIdTypes,
    @required this.photoIdNumber,
    @required this.nameController,
    @required this.onGenderChange,
    @required this.genders,
    @required this.selectedGender,
    @required this.formSubmit,
    @required this.birthDateController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 400,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Text(
                'Add New Member',
                textAlign: TextAlign.center,
              )),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 0,
                leading: Icon(Icons.contacts),
                title: DropdownButtonFormField(
                  hint: Text('Select Photo ID Proof*'),
                  validator: (val) {
                    return val != null ? null : 'Please select valid photo ID';
                  },
                  onChanged: onChangePhotoIdType,
                  value: selectedPhotoIdType,
                  items: photoIdTypes
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(
                            e['type'],
                          ),
                          value: e['id'].toString(),
                        ),
                      )
                      .toList(),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.contact_mail),
                  hintText: 'Photo ID Number',
                  labelText: 'Photo ID Number*',
                ),
                controller: photoIdNumber,
                validator: (idNum) {
                  return idNum.length >= 4 && idNum.length <= 14
                      ? null
                      : 'Photo Id number should be between 4 to 14 characters';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Name',
                  labelText: 'Name *',
                ),
                validator: (val) {
                  return val != null && val.length > 4
                      ? null
                      : 'Please add a valid Name';
                },
                controller: nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  hintText: 'Year Of Birth',
                  labelText: 'Year Of Birth*',
                ),
                validator: (val) {
                  return val != null && val.length == 4
                      ? null
                      : 'Please select valid Year of birth';
                },
                keyboardType: TextInputType.number,
                controller: birthDateController,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 0,
                leading: Image.asset(
                  'assets/images/outline_transgender_black_24dp.png',
                  width: 20,
                  height: 20,
                  color: Colors.black54,
                ),
                title: DropdownButtonFormField(
                  hint: Text('Select Gender*'),
                  onChanged: onGenderChange,
                  validator: (val) {
                    return val != null ? null : 'Please select Gender';
                  },
                  value: selectedGender,
                  items: genders
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(
                            e['gender'],
                          ),
                          value: e['id'].toString(),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  formSubmit(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    'Add Member',
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
