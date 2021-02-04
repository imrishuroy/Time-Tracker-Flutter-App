import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/avatar.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

class AccountsPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Text('Account'),
          actions: [
            FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: _buildUserInfo(user),
          )),
    );
  }

  Widget _buildUserInfo(AppUser user) {
    return Column(
      children: [
        Avatar(
          photoUrl: user.photoUrl,
          radius: 50,
        ),
        SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
