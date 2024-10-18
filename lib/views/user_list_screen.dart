import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/viewmodels/user_provider.dart';
import 'package:task/views/user_detail_screen.dart';
import 'package:task/views/search_bar.dart' as custom_search; // Custom search bar widget renamed

class UserListScreen extends StatefulWidget {
   UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  bool isGrid = false;
  String query = '';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:  Text('Users'),
        backgroundColor: Colors.teal, // Main app bar color
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          /// Custom SearchBar widget with the onSearch callback

          custom_search.SearchBar(onSearch: (value) {
            setState(() {
              query = value.toLowerCase();
            });
          }),

          /// Flexible widget allows the body to take available space
          Flexible(
            child: userProvider.isLoading && userProvider.users.isEmpty
                ?  Center(child: CircularProgressIndicator())
                : isGrid
                ? buildGridView(userProvider, screenWidth)
                : buildListView(userProvider, screenHeight),
          ),
        ],
      ),
    );
  }

  /// ListView with cards
  Widget buildListView(UserProvider userProvider, double screenHeight) {
    final filteredUsers = userProvider.users
        .where((user) =>
        '${user.firstName} ${user.lastName}'.toLowerCase().contains(query))
        .toList();

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02, vertical: screenHeight * 0.01),
      itemCount: filteredUsers.length,
      separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.01),
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.picture),
              radius: 30,
            ),
            title: Text(
              '${user.title} ${user.firstName} ${user.lastName}',
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.teal, // Title color
              ),
            ),
            subtitle: Text(
              'ID: ${user.id}',
              style:  TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing:  Icon(Icons.arrow_forward_ios, color: Colors.teal),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)),
            ),
          ),
        );
      },
    );
  }

  /// GridView with Card
  Widget buildGridView(UserProvider userProvider, double screenWidth) {
    final filteredUsers = userProvider.users
        .where((user) =>
        '${user.firstName} ${user.lastName}'.toLowerCase().contains(query))
        .toList();

    return GridView.builder(
      padding: EdgeInsets.all(screenWidth * 0.04),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: screenWidth * 0.04,
        mainAxisSpacing: screenWidth * 0.04,
        childAspectRatio: 3 / 4,
      ),
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)),
          ),
          child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      user.picture,
                      height: screenWidth * 0.24, // Responsive height
                      width: screenWidth * 0.25, // Responsive width
                      fit: BoxFit.cover,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.teal, // Name color
                    ),
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 4),
                  Text(
                    'ID: ${user.id}',
                    style:  TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
