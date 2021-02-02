import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';

import 'package:time_tracker/jobs/job.dart';
import 'package:time_tracker/services/database.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key key, this.database}) : super(key: key);
  final DataBase database;

  // static Future<void> show(BuildContext context) async {
  //   final database = Provider.of<DataBase>(context,listen:false);
  //   await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => AddJobPage(
  //         database: database,
  //       ),
  //       fullscreenDialog: true,
  //     ),
  //   );
  // }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();

  bool _validateAndSaveForm() {
    // form validaton
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String _name;
  int _rate;

  Future<void> _submit() async {
    // Validate and save form
    if (_validateAndSaveForm()) {
      // try {
      //   //print('Form Saved, Name: $_name, Rate: $_rate');
      //   final jobs = await widget.database.jobStream().first;

      //   final allNames = jobs.map((job) => job.name).toList();
      //   print('All Names: $allNames');
      //   if (allNames.contains(_name)) {
      //     PlatformAlertDialog(
      //       title: 'Name already used',
      //       contents: 'Please choose a different job name',
      //       defaultActionText: 'OK',
      //     ).show(context);
      //   } else {
      //     final job = Job(name: _name, ratePerHour: _rate);
      //     await widget.database.createJob(job);
      //     Navigator.of(context).pop();
      //   }

      try {
        final job = Job(name: _name, ratePerHour: _rate);
        await widget.database.createJob(job);
        Navigator.of(context).pop();
      } catch (error) {
        PlatformAlertDialog(
          title: 'Operation Failed 🙁',
          contents: 'Something went wrong. Please try again.',
          defaultActionText: 'OK',
        ).show(context);
      }
    }
  }

  // final TextEditingController _jobName = TextEditingController();
  // final TextEditingController _ratePerHour = TextEditingController();

  // Future<void> _createJob(BuildContext context) async {
  //   try {
  //     await widget.database.createJob(
  //       Job(
  //         name: _jobName.text,
  //         ratePerHour: int.parse(_ratePerHour.text),
  //       ),
  //     );
  //     Navigator.of(context).pop();
  //   } catch (error) {
  //     // permission-denied
  //     // print(error.code);
  //     print(error.toString());
  //     PlatformAlertDialog(
  //       title: 'Something went wrong 🙁',
  //       // contents: error.code == 'permission-denied'
  //       //     ? 'You don\'t have correct permissions. Check your permissions and try again'
  //       //     : 'Error Please try again',
  //       contents: 'Error',

  //       defaultActionText: 'OK',
  //     ).show(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Add Job'),
        actions: [
          FlatButton(
            onPressed: () {
              // _createJob(context);
              _submit();
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: buildContents(),
    );
  }

  Widget buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildFormChildren(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Job Name',
        ),
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty.',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Rate Per Hour',
        ),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        validator: (value) => value.isEmpty ? 'Rate can\t be null' : null,
        onSaved: (value) => _rate = int.tryParse(value) ?? 0,
      )
    ];
  }
}
