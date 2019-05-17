class DataRepository{

  static final DataRepository _instance = new DataRepository._internal();

  factory DataRepository(){
    return _instance;
  }

  DataRepository._internal();
}