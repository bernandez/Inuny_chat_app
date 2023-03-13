import 'package:flutter/material.dart';

const users = [
  usersara,
  userBrandone,
  userGreta



];

const usersara = DemoUser(
  id: 'Sara',
  name: 'Sara Pudu',
  image:
      'https://pbs.twimg.com/profile_images/1262058845192335360/Ys_-zu6W_400x400.jpg',
);

const userBrandone = DemoUser(
  id: 'Brandone',
  name: 'Alouzeh Brandone',
  image:
      'https://pbs.twimg.com/profile_images/1262058845192335360/Ys_-zu6W_400x400.jpg',
);

const userGreta = DemoUser(
  id: 'Greta',
  name: 'Greta Caso',
  image:
      'https://pbs.twimg.com/profile_images/1262058845192335360/Ys_-zu6W_400x400.jpg',
);





@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;

  const DemoUser({
    required this.id,
    required this.name,
    required this.image,
  });
}
