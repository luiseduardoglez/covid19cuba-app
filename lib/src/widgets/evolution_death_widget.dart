import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:covid19cuba/src/utils/utils.dart';
import 'package:covid19cuba/src/models/models.dart';

class EvolutionDeathWidget extends StatelessWidget {
  final EvolutionOfDeathsByDays evolutionOfDeathsByDays;

  const EvolutionDeathWidget({this.evolutionOfDeathsByDays})
      : assert(evolutionOfDeathsByDays != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Center(
            child: Text(
              'Evolución de fallecidos por días',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          height: 300,
          child: charts.TimeSeriesChart(
            [
              charts.Series<int, DateTime>(
                id: evolutionOfDeathsByDays.daily.name,
                colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
                domainFn: (_, i) => dateTimeFromJson(
                  evolutionOfDeathsByDays.date.values[i].toStr(),
                ),
                measureFn: (item, _) => item,
                data: evolutionOfDeathsByDays.daily.values,
              ),
              charts.Series<int, DateTime>(
                id: evolutionOfDeathsByDays.accumulated.name,
                colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                domainFn: (_, i) => dateTimeFromJson(
                  evolutionOfDeathsByDays.date.values[i].toStr(),
                ),
                measureFn: (item, _) => item,
                data: evolutionOfDeathsByDays.accumulated.values,
              ),
            ],
            animate: false,
            defaultInteractions: true,
            defaultRenderer: charts.LineRendererConfig(
              includePoints: true,
            ),
            behaviors: [
              charts.ChartTitle(
                'Fecha',
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleStyleSpec: charts.TextStyleSpec(fontSize: 11),
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea,
              ),
              charts.ChartTitle(
                'Fallecidos',
                behaviorPosition: charts.BehaviorPosition.start,
                titleStyleSpec: charts.TextStyleSpec(fontSize: 11),
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea,
              ),
              charts.SeriesLegend(
                position: charts.BehaviorPosition.bottom,
                desiredMaxColumns: 1,
                showMeasures: true,
              ),
              charts.LinePointHighlighter(
                showHorizontalFollowLine:
                    charts.LinePointHighlighterFollowLineType.all,
                showVerticalFollowLine:
                    charts.LinePointHighlighterFollowLineType.nearest,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
