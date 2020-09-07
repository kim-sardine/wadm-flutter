import 'package:table_sticky_headers/table_sticky_headers.dart';

class MyCellDimensions extends CellDimensions {
  final double contentCellWidth;
  final double contentCellHeight;
  final double stickyLegendWidth;
  final double stickyLegendHeight;

  const MyCellDimensions({
    this.contentCellWidth,
    this.contentCellHeight,
    this.stickyLegendWidth,
    this.stickyLegendHeight,
  });

  MyCellDimensions.fromJson(Map<String, dynamic> data)
  : contentCellWidth = data['contentCellWidth'],
    contentCellHeight = data['contentCellHeight'],
    stickyLegendWidth = data['stickyLegendWidth'],
    stickyLegendHeight = data['stickyLegendHeight'];

  Map<String, dynamic> toJson() => {
    'contentCellWidth': this.contentCellWidth,
    'contentCellHeight': this.contentCellHeight,
    'stickyLegendWidth': this.stickyLegendWidth,
    'stickyLegendHeight': this.stickyLegendHeight,
  };
}
