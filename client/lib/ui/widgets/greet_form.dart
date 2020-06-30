import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/greet/greet_bloc.dart';

class GreetForm extends StatefulWidget {
  final String addLabel;
  final String submitLabel;
  final bool addEnabled;
  final bool submitEnabled;
  final Function(String, String) onAdd;
  final Function(String, String) onSubmit;

  const GreetForm({
    this.addLabel,
    this.submitLabel,
    this.addEnabled = true,
    this.submitEnabled = true,
    this.onAdd,
    @required this.onSubmit,
  });

  @override
  _GreetFormState createState() => _GreetFormState();
}

class _GreetFormState extends State<GreetForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GreetBloc, GreetState>(
      listener: (context, state) {
        if (state is GreetInitial) {
          _counter = 0;
          formKey.currentState.reset();
        }
      },
      child: Form(
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
            if (widget.onAdd != null) ...[
              const SizedBox(height: 20),
              RaisedButton(
                child: Text(widget.addLabel ?? 'Add ($_counter)'),
                onPressed: widget.addEnabled
                    ? () async {
                        if (formKey.currentState.validate()) {
                          widget.onAdd(_firstName, _lastName);
                          setState(() {
                            _counter++;
                          });
                        }
                      }
                    : null,
              ),
            ],
            const SizedBox(height: 20),
            RaisedButton(
              child: Text(widget.submitLabel ?? 'Submit'),
              onPressed: widget.submitEnabled
                  ? () async {
                      if (formKey.currentState.validate()) {
                        widget.onSubmit(_firstName, _lastName);
                        setState(() {
                          _counter = 0;
                        });
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
