import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker/jobs/add_job_page.dart';

import 'package:time_tracker/jobs/job_list_tile.dart';

import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

class JobsPage extends StatelessWidget {
  void _signOutUser(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOutUser();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      contents: 'Are you sure that you want to logout',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);

    if (didRequestSignOut == true) {
      _signOutUser(context);
    }
  }

  // Future<void> _createData(BuildContext context) async {
  //   try {
  //     final database = Provider.of<DataBase>(context, listen: false);
  //     await database.createJob(
  //       Job(
  //         name: 'Blogging',
  //         ratePerHour: 10,
  //       ),
  //     );
  //   } catch (error) {
  //     // permission-denied
  //     print(error.code);
  //     PlatformAlertDialog(
  //       title: 'Something went wrong 🙁',
  //       contents: error.code == 'permission-denied'
  //           ? 'You don\'t have correct permissions. Check your permissions and try again'
  //           : 'Error Please try again',
  //       defaultActionText: 'OK',
  //     ).show(context);
  //   }
  // }

  Widget buildContents(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder(
      stream: database.jobStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // final jobs = snapshot.data;
          // final children = jobs.map((job) => Text(job.name)).toList();
          // return ListView(
          //   children: children,
          // );

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              String jobName = snapshot.data[index]['name'];

              return JobListTile(
                jobName: jobName,
                onTap: () {},
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddJobPage(
              database: database,
            ),
          ),
        ),
        // onPressed: () => AddJobPage.show(context),

        // onPressed: () => _createData(context),
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: buildContents(context),
    );
  }
}
