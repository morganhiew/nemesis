enum Category {
  year, subject, area
}

class FilterTeacherChip {
  final Category category;
  final String label;
  final String description;

  const FilterTeacherChip ({this.category, this.label, this.description});
}

class FilterTeacherYearChip extends FilterTeacherChip {
  final int year;

  const FilterTeacherYearChip ({this.year, String label, String description}):
  super(category: Category.year, label: label, description: description);
}
