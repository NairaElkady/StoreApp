import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/widget/user_widget.dart';

import '../consts/global_colors.dart';
import '../models/users_model.dart';
import '../services/api_handler.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightCardColor,
        title: const Text("Users"),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHendler.getAllUsers(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text("An error occured ${snapshot.error}"),
            );
          } else if (snapshot.data == null) {
            const Center(
              child: Text("No products has been added yet"),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const UserWidget(),
                );
              });
        }),
      ),
    );
  }
}
