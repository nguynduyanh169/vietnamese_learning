class TileModel{

  String vocabulary;
  String description;
  bool isSelected;
  String image;

  TileModel({this.vocabulary, this.description, this.isSelected, this.image});

  String getImage(){
    return image;
  }

  void setImage(String newImage){
    image = newImage;
  }
  String getVocabulary(){
    return vocabulary;
  }

  void setVocabulary(String newVocabulary){
    vocabulary = newVocabulary;
  }

  String getDescription(){
    return description;
  }

  void setDiscription(String newDiscription){
    vocabulary = newDiscription;
  }
  void setIsSelected(bool getIsSelected){
    isSelected = getIsSelected;
  }

  bool getIsSelected(){
    return isSelected;
  }
}