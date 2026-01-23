class HomeCardItemEntity {
  HomeCardItemEntity({
    required this.image,
    required this.title,
    this.onTap,
    this.isNextFlag = false,
  });

  String image;
  String title;
  bool isNextFlag;
  void Function()? onTap;
}
