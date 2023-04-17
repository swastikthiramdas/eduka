import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduka/models/user_model.dart';
import 'package:eduka/providers/user_provider.dart';
import 'package:eduka/screens/profile_edit_screen.dart';
import 'package:eduka/widgets/profile_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileViewScreen extends StatelessWidget {
  ProfileViewScreen({Key? key}) : super(key: key);

  bool isShow = false;

  Widget CourceView(final snap) {
    final thub = snap['thubnailUrl'];
    return Container(
      margin: const EdgeInsets.all(10),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: thub == null
                ? BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(thub),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          Text(
            snap['tittle'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Text(
            snap['name'],
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget getEnrollData(String uid) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('cources')
          .where('enrolls', arrayContains: uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        }
        return SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              snapshot.data!.docs.length == 0 ? isShow = false: isShow = true;
              return snapshot.data!.docs.length != 0
                  ? GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>)),
                  );*/
                      },
                      child: CourceView(
                        snapshot.data!.docs[index].data(),
                      ),
                    )
                  : Center(
                      child: Text('No Data Available'),
                    );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => ProfileEditScreen(firstname: _user.firstname!, lastname: _user.lastname!, email: _user.email!, url: _user.photoUrl!, id: _user.uid!,))));
                            },
                            icon: Icon(Icons.edit_off),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                            radius: 34,
                            backgroundImage: NetworkImage(_user.photoUrl!),
                          ),
                        ),
                        SizedBox(height: 20),
                        ProfileText(
                          cat: 'Name',
                          data: "${_user.firstname!} ${_user.lastname!}",
                        ),
                        SizedBox(height: 10),
                        ProfileText(
                          cat: 'Email',
                          data: _user.email!,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isShow,
                  child: Column(
                    children: [
                      Text(
                        'Explore New Cources',
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      getEnrollData(_user.uid!)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
