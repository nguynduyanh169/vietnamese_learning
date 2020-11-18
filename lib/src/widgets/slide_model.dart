
class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "This appication like a book for you, make the easiest way to learn Vietnamese as fast as you can");
  sliderModel.setTitle("Convinient");
  sliderModel.setImageAssetPath("assets/images/splashscreen1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Our application have plenty of function that make your study more effective");
  sliderModel.setTitle("Multifunction");
  sliderModel.setImageAssetPath("assets/images/splashscreen2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "We base on standar curriculum to make a quality lesson and make a best practice for your study");
  sliderModel.setTitle("Standar Curriculum");
  sliderModel.setImageAssetPath("assets/images/splashscreen3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //4
  sliderModel.setDesc(
      "Make yourself best practice in Vietnamese, and we hope you get a best result");
  sliderModel.setTitle("Explore");
  sliderModel.setImageAssetPath("assets/images/splashscreen4.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
