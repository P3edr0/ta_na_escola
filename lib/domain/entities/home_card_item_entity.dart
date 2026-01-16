class HomeCardItemEntity {
  HomeCardItemEntity({required this.image, required this.title, this.onTap});

  String image;
  String title;
  void Function()? onTap;
}
