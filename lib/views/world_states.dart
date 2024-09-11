import 'package:flutter/material.dart';
import 'package:flutter_covid_19/services/state_services.dart';
import 'package:flutter_covid_19/views/countries_list.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              FutureBuilder(
                future: stateServices.fetchWorldRecords(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                        child: SpinKitFadingCircle(
                        size: 50,
                        controller: _controller,
                        color: Colors.black,
                      )
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                        PieChart(
                          dataMap: {
                            "Total" : double.parse(snapshot.data!.cases!.toString()),
                            "Recovered" : double.parse(snapshot.data!.recovered!.toString()),
                            "Deaths" : double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          animationDuration: Duration(seconds: 1),
                          // chartType: ChartType.ring,
                          colorList: [
                            Colors.blue,
                            Colors.green,
                            Colors.red
                          ],
                          // legendOptions: LegendOptions(
                          //   legendPosition: LegendPosition.left,
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            color: Colors.grey.shade200,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total'),
                                      Text(snapshot.data!.cases.toString())
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Recovered'),
                                      Text(snapshot.data!.recovered.toString())
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Deaths'),
                                      Text(snapshot.data!.deaths.toString())
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Active'),
                                      Text(snapshot.data!.active.toString())
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Critical'),
                                      Text(snapshot.data!.critical.toString())
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList()));
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text('World Statistics', style: TextStyle(color: Colors.white),),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade800,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }
              ),



            ],
        ),
        )
      ),
    );
  }
}

