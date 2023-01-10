import 'package:flutter/material.dart';

import 'airbnb_details.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExplorePage();
}

class _ExplorePage extends State<Explore> {
  String _selected = "Beach";
  String _searchString = "";

  final List _cardList = [
    ["Braga, Portugal", "casa4.jpeg", 5.0, "Pool and Castle View", "13-21 Oct", 27.900],
  ];

  final List _cardListBeache = [
    ["Mikonos, Greece", "mikonos.jpeg", 4.81, "Beach and Mountain View", "4-9 Feb", 23.469],
    ["Porto, Portugal", "beach.jpeg", 4.69, "Beach View ", "6-11 April", 20.030],
    ["Sicily, Italy", "italya_beach.html", 4.9, "Amazing Sicily View", "13-21 May", 19.300],
  ];

  static const List<String> _searchOptions = <String>[
    'Mikanos',
    'Porto',
    'Sicily'
  ];

  Widget _createCard(List cardInfo) {
    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AirbnbDetailsScreen(
                      title: cardInfo[0],
                      image: cardInfo[1],
                      location: cardInfo[3],
                    ))),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ) ,
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Image(image: AssetImage('images/${cardInfo[1]}'
                            )
                            ),
                          ),
                        ),

                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                cardInfo[0],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              alignment: Alignment.centerRight,
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: cardInfo[2].toString(),
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  const WidgetSpan(
                                      child: Icon(
                                    Icons.star,
                                    size: 14,
                                  ))
                                ]),
                              ),
                            )
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              cardInfo[3],
                              style: const TextStyle(color: Colors.grey),
                            )),
                        Container(
                            padding: const EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              cardInfo[4],
                              style: const TextStyle(color: Colors.grey),
                            )),
                        Container(
                            padding: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '₺ ${cardInfo[5]}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _createFilterCard(String title, IconData icon) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(title == _selected
            ? Colors.black
            : const Color.fromARGB(255, 138, 138, 138)),
      ),
      onPressed: () => {
        setState(() {
          _selected = title;
        }),
      },
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 14,
          ),
          Text(
            title,
            style: title == _selected
                ? const TextStyle(color: Colors.black)
                : const TextStyle(color: Color.fromARGB(255, 138, 138, 138)),
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Padding(
            //padding: const EdgeInsets.all(20),
            padding:
                const EdgeInsets.only(left: 20, top: 50, right: 20, bottom: 10),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _searchOptions.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  _searchString = selection;
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 50,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    onChanged: (String selection) {
                      setState(() {
                        _searchString = selection;
                      });
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none),
                      hintText: "Where to?",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 65,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    _createFilterCard("Beach", Icons.beach_access),
                    _createFilterCard("Pool", Icons.pool),
                    _createFilterCard("Bungalow", Icons.bungalow_sharp),
                    _createFilterCard("Extraordinary", Icons.architecture),
                    _createFilterCard("Castle", Icons.castle),
                    _createFilterCard("Ski", Icons.skateboarding_outlined),
                    _createFilterCard("North Pole", Icons.sunny_snowing),
                  ]),
                ),
              ],
            ),
          ),
          //const Divider(),
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  LayoutBuilder(builder: (context, constraints) {
                    if (_selected == "Beach") {
                      return Column(
                          children: _cardListBeache
                              .map((cardInfo) => cardInfo[0]
                                      .toString()
                                      .toLowerCase()
                                      .contains(_searchString.toLowerCase())
                                  ? _createCard(cardInfo)
                                  : const SizedBox.shrink())
                              .toList());
                    } else if (_selected == "Pool") {
                      return Column(
                          children: _cardList
                              .map((cardInfo) => _createCard(cardInfo))
                              .toList());
                    }else {
                      return const Text("Error");
                    }
                  })
                ]),
              ),
            ],
          ))
        ]),
      ),
    );
  }
}
