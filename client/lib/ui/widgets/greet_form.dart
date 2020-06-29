import 'package:flutter/material.dart';

class GreetForm extends StatefulWidget {
  final Function(String, String) onSubmit;

  const GreetForm({
    @required this.onSubmit,
  });

  @override
  _GreetFormState createState() => _GreetFormState();
}

class _GreetFormState extends State<GreetForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (fname) => _firstName = fname,
            validator: (fname) {
              if (fname.isEmpty) {
                return 'Please enter a first name.';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'First Name',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (lname) => _lastName = lname,
            validator: (lname) {
              if (lname.isEmpty) {
                return 'Please enter a last name.';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Last Name',
            ),
          ),
          const SizedBox(height: 20),
          RaisedButton(
            child: Text('Greet'),
            onPressed: () async {
              if (formKey.currentState.validate()) {
                widget.onSubmit(_firstName, _lastName);
              }
            },
          ),
        ],
      ),
    );
  }
}
