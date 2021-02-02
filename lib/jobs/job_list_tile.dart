import 'package:flutter/material.dart';

class JobListTile extends StatelessWidget {
  final String jobName;
  final VoidCallback onTap;

  const JobListTile({Key key, this.jobName, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(jobName),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right),
    );
  }
}
