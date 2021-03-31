class Month {
  late final String id;
  DateTime firstDay = DateTime.now();
  Map<String, List<DateTime>> dayAndDate = {
    'Sunday': [],
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': []
  };
  Month({required this.id});

}
