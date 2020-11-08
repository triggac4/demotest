class Month {
  final String id;
  Map<String, List<DateTime>> dayAndDate = {
    'Sunday': [],
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': []
  };
  Month({this.id});
}
