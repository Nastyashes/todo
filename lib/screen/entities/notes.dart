class Notes {
  String? headline;
  String? description;
  bool? isCompleted;

Notes({this.headline, this.description, this.isCompleted});
}
List<Notes> notes = [
  Notes(
    headline: 'First',
    description: 'This is first notes in test',
    isCompleted: false)
];

