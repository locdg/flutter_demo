import 'package:hive/hive.dart';
import 'package:user_interface/RestfulAPI/DioClient.dart';
part 'User.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0, defaultValue: '')
  String name;

  @HiveField(1, defaultValue: 0)
  int age;

  @HiveField(2, defaultValue: [])
  List<User> listUser;

  User(this.name, this.age, this.listUser);
}


