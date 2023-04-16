import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduka/models/user_model.dart';
import 'package:eduka/providers/user_provider.dart';
import 'package:eduka/screens/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cource_open_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  String cat = "python";
  String? firstname;
  bool complete = true;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context , listen: false);
    await _userProvider.refreshUser();
    setState(() {
      complete = false;
    });
  }



  Widget CourceView(final snap) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: snap['thubnailUrl'] == null
                ? BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(snap['thubnailUrl'].toString()),
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

  Widget getData() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('cources')
          .where('category', isEqualTo: cat)
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
              return snapshot.data!.docs.length != 0
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => CourceOpenScreen(
                                  snap: snapshot.data!.docs[index].data(),
                                )),
                          ),
                        );
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

  ChnageScreen(int screen) {
    setState(() {
      _currentPage = screen;
      if (_currentPage == 0) {
        cat = "python";
      } else if (_currentPage == 1) {
        cat = "web development";
      } else if (_currentPage == 2) {
        cat = "javascript";
      } else if (_currentPage == 3) {
        cat = "android development";
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final UserModel _user = Provider.of<UserProvider>(context).getUser;
    print(_auth.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: [
            SizedBox(width: 40),
            Text(
              'Eduka',
              style: TextStyle(
                fontSize: 24,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Course',
                        hintStyle: TextStyle(fontSize: 12),
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => UploadScreen())));
            },
            icon: Icon(
              Icons.cloud_upload_rounded,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                minRadius: 22,
                backgroundColor: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Welcome!!  ${_user.firstname}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => ChnageScreen(0),
                          child: Text(
                            'Python',
                            style: TextStyle(
                              color:
                                  _currentPage == 0 ? Colors.black87 : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => ChnageScreen(1),
                          child: Text(
                            'Web Development',
                            style: TextStyle(
                              color:
                                  _currentPage == 1 ? Colors.black87 : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => ChnageScreen(2),
                          child: Text(
                            'JavaScript',
                            style: TextStyle(
                              color:
                                  _currentPage == 2 ? Colors.black87 : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => ChnageScreen(3),
                          child: Text(
                            'Android Development',
                            style: TextStyle(
                              color:
                                  _currentPage == 3 ? Colors.black87 : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    getData(),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: complete,
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}

