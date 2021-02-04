import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker/jobs/add_job_page.dart';

import 'package:time_tracker/jobs/job_list_tile.dart';

import 'package:time_tracker/services/database.dart';

class JobsPage extends StatelessWidget {
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

  Future<void> _deleteJob(BuildContext context) async {
    try {
      final databse = Provider.of<DataBase>(context, listen: false);
      await databse.deleteData();
    } catch (error) {
      PlatformAlertDialog(
        title: 'Something went wrong 🙁',
        contents: error.code == 'permission-denied'
            ? 'You don\'t have correct permissions. Check your permissions and try again'
            : 'Error Please try again',
        defaultActionText: 'OK',
      ).show(context);
    }
  }

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

          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, i) => Divider(height: 0.7),
            itemBuilder: (context, index) {
              String jobName = snapshot.data[index]['name'];

              return JobListTile(
                jobName: jobName,
                onTap: () {
                  _deleteJob(context);
                },
              );

              //     Dismissible(
              //   key: Key('job$jobName'),
              //   background: Container(
              //     color: Colors.red,
              //   ),
              //   direction: DismissDirection.endToStart,
              //   onDismissed: (direction) => _deleteJob(context),
              //   child: JobListTile(
              //     jobName: jobName,
              //     onTap: () {},
              //   ),
              // );
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AddJobPage(
      //         database: database,
      //       ),
      //     ),
      //   ),
      //   // onPressed: () => AddJobPage.show(context),

      //   // onPressed: () => _createData(context),
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddJobPage(
                  database: database,
                ),
              ),
            ),
          ),
        ],
      ),
      body: buildContents(context),
    );
  }
}
