import 'package:hive/hive.dart';
part 'save_progress_local.g.dart';

@HiveType(typeId: 1)
class SaveProgressLocal{
  
  @HiveField(0)
   String lessonID;
  
  @HiveField(1)
   double vocabProgress;

  @HiveField(2)
   double converProgress;

  @HiveField(3)
   double quizProgress;

  @HiveField(4)
   DateTime updateTime;

  @HiveField(5)
   bool isSync;

   SaveProgressLocal({this.lessonID, this.vocabProgress, this.converProgress, this.quizProgress, this.updateTime, this.isSync});

}