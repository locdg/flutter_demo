import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_interface/RestfulAPI/DioClient.dart';
import 'dart:math';
part 'DioDemo.g.dart';

class DioDemo extends StatefulWidget {
  const DioDemo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DioDemo> createState() => DioDemoState();
}

class DioDemoState extends State<DioDemo> {
  late Future<User?> futureUser;
  final MyServices services = MyServices();
  @override
  void initState() {
    super.initState();
    futureUser = services.getUser(id: '2');
  }

  void loadUser(String id) {
    futureUser = services.getUser(id: '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              User? user = snapshot.data;
              if (user == null) {
                return const Text('Error');
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(user.data.avatar),
                  const SizedBox(height: 8.0),
                  Text(
                    '${user.data.firstName} ${user.data.lastName}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    user.data.email,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.data == null) {
              return Text('${snapshot.error}');
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Random random = new Random();
          int randomNumber = random.nextInt(10);
          setState(() {
            loadUser('$randomNumber');
          });

          //   services.createUser(
          //       userInfo: UserInfo(name: 'Dong Gia Loc', job: 'IT'));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

@JsonSerializable()
class Data {
  @JsonKey(required: true)
  int id;

  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String avatar;

  Data(this.id, this.email, this.firstName, this.lastName, this.avatar);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  Data data;
  User(this.data);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserInfo {
  String name;
  String job;
  String? id;
  String? createdAt;
  String? updatedAt;

  UserInfo({
    required this.name,
    required this.job,
    this.id,
    this.createdAt,
    this.updatedAt,
  });
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
