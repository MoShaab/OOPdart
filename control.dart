import 'dart:io';
import 'dart:convert';

// Interface for countries
abstract class Country {
  String name;
  double population;
  int electionCycle;
  double coastline;

  Country(this.name, this.population, this.electionCycle, this.coastline);

  void displayDetails();
}

// Class implementing the Country interface
class CountryImpl extends Country {
  CountryImpl(
      String name, double population, int electionCycle, double coastline)
      : super(name, population, electionCycle, coastline);

  @override
  void displayDetails() {
    print('Country: $name');
    print('Population: $population million');
    print('Election cycle: $electionCycle years');
    print('Coastline: $coastline km');
  }
}

// Main function to demonstrate the program
void main() {
  List<Country> countries = [];

  // Read data from file
  try {
    File file = File('countries.csv');
    Stream<List<int>> inputStream = file.openRead();

    inputStream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .forEach((line) {
      print('$line');
      // Skip lines that are headers
      if (!line.startsWith("Country")) {
        List<String> data = line.split(', ');
        if (data.length == 4) {
          String name = data[0];
          double population = double.parse(data[1]);
          int electionCycle = int.parse(data[2]);
          double coastline = double.parse(data[3]);
          countries
              .add(CountryImpl(name, population, electionCycle, coastline));
        }
      }
    });
  } catch (e) {
    print('Error reading file: $e');
  }

  // Display column names
  print('----------------------------------');

  print('Country    Population    Election Cycle    Coastline');

  // Display details of each country
  for (Country country in countries) {
    country.displayDetails();
  }
}
