import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:insta_clone/import.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  bool isShowuser = false;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search for a user',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowuser = true;
            });
          },
        ),
      ),
      body: isShowuser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              // initialData: InitialData,
              builder: (context, AsyncSnapshot snapshot) {
                // dynamic data = (snapshot.data! as dynamic).docs;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]
                                ['photoUrl']),
                      ),
                      title: Text(
                          (snapshot.data! as dynamic).docs[index]['username']),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              // initialData: InitialData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
                    for (int i = 0;
                        i < (snapshot.data! as dynamic).docs.length;
                        i++)
                      StaggeredGridTile.count(
                        crossAxisCellCount: i % 3 == 0 ? 2 : 1,
                        mainAxisCellCount: i % 3 == 0 ? 2 : 1,
                        child: Image.network(
                          (snapshot.data! as dynamic).docs[i]['postUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}
