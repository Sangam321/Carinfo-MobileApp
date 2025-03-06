import 'package:carinfo/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:carinfo/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(state.user.photoUrl),
                  ),
                  SizedBox(height: 16),
                  Text("Name: ${state.user.name}",
                      style: TextStyle(fontSize: 20)),
                  Text("Email: ${state.user.email}",
                      style: TextStyle(fontSize: 16)),
                  Text("Role: ${state.user.role}",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}
