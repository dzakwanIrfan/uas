import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<double> data;

  const WeeklyBarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return Container(); // Handle empty data case

    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: data.reduce((a, b) => a > b ? a : b) * 1.2,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.blueAccent,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'Rp ${rod.toY.toStringAsFixed(0)}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Sen',
                    'Sel',
                    'Rab',
                    'Kam',
                    'Jum',
                    'Sab',
                    'Min'
                  ];
                  int index = value.toInt();
                  if (index >= 0 && index < days.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(days[index]),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('${(value / 1000000).toStringAsFixed(1)}M'),
                  );
                },
                reservedSize: 40,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: data.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value,
                  color: Colors.blue,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TopProductsPieChart extends StatelessWidget {
  final List<String> products;
  final List<double> sales;

  const TopProductsPieChart({
    Key? key,
    required this.products,
    required this.sales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty || sales.isEmpty) return Container();

    final total = sales.reduce((a, b) => a + b);

    return AspectRatio(
      aspectRatio: 1.5,
      child: PieChart(
        PieChartData(
          sections: List.generate(products.length, (index) {
            final percentage = (sales[index] / total * 100).toStringAsFixed(1);
            return PieChartSectionData(
              color: Colors.primaries[index % Colors.primaries.length],
              value: sales[index],
              title: '$percentage%',
              radius: 100,
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }),
          sectionsSpace: 2,
          centerSpaceRadius: 0,
        ),
      ),
    );
  }
}
