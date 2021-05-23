import 'package:diploma_flutter_app/pages/profile/auth_profile_page.dart';
import 'package:diploma_flutter_app/pages/profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  Future<bool> _status;

  @override
  void initState() {
    super.initState();
    _status = isUserExist();
  }

  void _retry() {
    setState(() {
      _status = isUserExist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<bool>(
        future: _status,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            print("data __ + ${snapshot.data}");
            return snapshot.data ? UserProfile() : AuthProfilePage();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _retry();
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text("Ошибка", textAlign: TextAlign.center),
              ],
            );
            ;
          }
        },
      ),
      //child: status ? UserProfile() : AuthProfilePage(),
    );
  }

  Future<bool> isUserExist() async {
    final prefs = await SharedPreferences.getInstance();
    print("role ++ # ${prefs.getInt('role')}");
    return prefs.getInt('role') != 0 && prefs.getInt('role') != null
        ? true
        : false;
  }
}
