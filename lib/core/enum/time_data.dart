enum TimeDate {
  pm(1, 'مساءاً'),
  am(2, 'صباحاً');

  final int id;
  final String name;
  const TimeDate(this.id, this.name);
}