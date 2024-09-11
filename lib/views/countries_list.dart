import 'package:flutter/material.dart';
import 'package:flutter_covid_19/services/state_services.dart';
import 'package:flutter_covid_19/views/details_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: stateServices.countriesListApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(height: 50 , width: 50, color: Colors.white,),
                              title: Container(
                                width: 100,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailsScreen(
                              image: snapshot.data![index]['countryInfo']['flag'],
                              name: snapshot.data![index]['country'] ,
                              totalCases:  snapshot.data![index]['cases'] ,
                              totalRecovered: snapshot.data![index]['recovered'] ,
                              totalDeaths: snapshot.data![index]['deaths'],
                              active: snapshot.data![index]['active'],
                              test: snapshot.data![index]['tests'],
                              todayRecovered: snapshot.data![index]['todayRecovered'],
                              critical: snapshot.data![index]['critical'] ,
                            )));
                          },
                          child: ListTile(
                            leading: Image(
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                              height: 50,
                              width: 50,
                            ),

                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text('Effected' + snapshot.data![index]['cases'].toString()),
                          ),
                        )
                      ],
                    );
                  }
                );
              }
            )
          )
        ],
      ),
    );
  }
}

