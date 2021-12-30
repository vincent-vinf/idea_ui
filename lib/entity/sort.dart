class Sort {
  String content;
  String img;
  int typeId = 0;

  Sort(this.content, this.img) {
    Map typeMap = {
      "体育": 1,
      "军事": 2,
      "娱乐": 3,
      "政治": 4,
      "教育": 5,
      "社会": 7,
      "科技": 8,
      "财经": 9,
    };
    typeId = typeMap[content];
  }
}
