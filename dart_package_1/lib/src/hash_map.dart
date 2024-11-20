void main() {
  Map cityCountry = Map<String, String>();

  cityCountry['New York'] = 'USA';
  cityCountry['London'] = 'UK';
  cityCountry['Paris'] = 'France';
  cityCountry['Berlin'] = 'Germany';

  cityCountry.forEach((city, country) {
    print('$city is in $country');
  });
}
