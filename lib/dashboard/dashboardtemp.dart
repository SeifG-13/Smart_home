import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatefulWidget {
  const TemperatureChart({super.key});

  @override
  State<TemperatureChart> createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],  // Grey background for the whole screen
      appBar: AppBar(
        title: Text('Temperature Chart', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.grey[200],  // Grey background for the app bar
        elevation: 0,  // Remove shadow from the app bar
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],  // Grey background for the chart container
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: LineChartWidget(),
        ),
      ),
    );
  }
}

class Titles {
  static FlTitlesData getTitleData() => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 60,
        getTitlesWidget: (value, meta) {
          const style = TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,  // Black text for X-axis titles
          );
          String text;
          switch (value.toInt()) {
            case 0:
              text = '01 Aug';
              break;
            case 1:
              text = '02 Aug';
              break;
            case 2:
              text = '03 Aug';
              break;
            case 3:
              text = '04 Aug';
              break;
            case 4:
              text = '05 Aug';
              break;
            case 5:
              text = '06 Aug';
              break;
            case 6:
              text = '07 Aug';
              break;
            case 7:
              text = '08 Aug';
              break;
            case 8:
              text = '09 Aug';
              break;
            case 9:
              text = '10 Aug';
              break;
            case 10:
              text = '11 Aug';
              break;
            case 11:
              text = '12 Aug';
              break;
            default:
              text = '';
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(text, style: style),
            ),
          );
        },
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (value, meta) {
          const style = TextStyle(
            color: Colors.black,  // Black text for Y-axis titles
            fontWeight: FontWeight.bold,
            fontSize: 13,
          );
          String text;
          if (value.toInt() % 10 == 0) {
            text = '$value°C';
          } else {
            text = '';
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(text, style: style),
            ),
          );
        },
      ),
    ),
  );
}

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    Colors.blueAccent,
    Colors.lightBlueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 40,  // Adjusted for temperature values
        titlesData: Titles.getTitleData(),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[600] ?? Colors.grey,  // Grey color for grid lines
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey[600] ?? Colors.grey,  // Grey border color
            width: 2,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 30),
              FlSpot(1, 32),
              FlSpot(2, 31),
              FlSpot(3, 29),
              FlSpot(4, 35),
              FlSpot(5, 34),
              FlSpot(6, 36),
              FlSpot(7, 33),
              FlSpot(8, 37),
              FlSpot(9, 38),
              FlSpot(10, 34),
              FlSpot(11, 32),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: gradientColors.first.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
