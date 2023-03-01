import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ToDoChart extends StatefulWidget {
  final int? sl1;
  final int? sl2;
  final int? sl3;
  const ToDoChart({this.sl1, this.sl2, this.sl3});

  @override
  State<ToDoChart> createState() =>
      _ToDoChartState(sl1: sl1, sl2: sl2, sl3: sl3);
}

class _ToDoChartState extends State<ToDoChart> {
  final int? sl1;
  final int? sl2;
  final int? sl3;
  _ToDoChartState({this.sl1, this.sl2, this.sl3});
  late List<Data> _charData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> textScr = [];
  void douuu() {
    final lang = Localizations.localeOf(context).languageCode.toString();
    if (lang == 'vi') {
      textScr = [
        'Thống kê số công việc hoàn thành theo dạng biểu đồ hình tròn',
        'Cao',
        'Trung bình',
        'Thấp'
      ];
    } else {
      textScr = [
        'Statistics on the number of completed tasks in the form of a pie chart',
        'Hight',
        'Medium',
        'Low'
      ];
    }
    _charData = getChartData(sl1, sl2, sl3);
  }

  @override
  Widget build(BuildContext context) {
    douuu();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: LocaleText(
            'bieudo'.tr,
            style: GoogleFonts.beVietnamPro(),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: SfCircularChart(
          title: ChartTitle(
              text: textScr[0],
              textStyle:
                  GoogleFonts.beVietnamPro(color: Colors.deepPurpleAccent)),
          legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              textStyle: GoogleFonts.beVietnamPro(color: Colors.deepPurple)),
          series: <CircularSeries>[
            DoughnutSeries<Data, String>(
              dataSource: _charData,
              xValueMapper: (Data data, _) => data.continent,
              pointColorMapper: (Data data, _) => data.color,
              yValueMapper: (Data data, _) => data.value,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle:
                    GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Data> getChartData(int? sl1, int? sl2, int? sl3) {
    final List<Data> chartData = [
      Data(textScr[1], sl1 == null ? 0 : sl1, Colors.redAccent),
      Data(textScr[2], sl2 == null ? 0 : sl2, Colors.blueAccent),
      Data(textScr[3], sl3 == null ? 0 : sl3, Colors.greenAccent),
    ];
    return chartData;
  }
}

class Data {
  final String continent;
  final int value;
  final Color color;
  Data(this.continent, this.value, this.color);
}
