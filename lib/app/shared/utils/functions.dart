String bodyTypeToImage(String bodyType) {
  switch (bodyType) {
    case 'Convertible':
      return 'convertible';
    case 'Coupe':
      return 'sportscar';
    case 'Hatchback':
      return 'hatchback';
    case 'Sedan':
      return 'saloon';
    case 'Saloon':
      return 'saloon';
    case 'Station Wagon':
      return 'stationwagon';
    case 'RV/SUV':
      return 'suv';
    case 'Ute':
      return 'pickup';
    case 'Van':
      return 'van';
    case 'Classic':
      return 'classic';
    case 'Hybrid':
      return 'hybrid';
    case 'Truck':
      return 'truck';
    default:
      return '';
  }
}

String titleToSortOrder(String sortOrder) {
  switch (sortOrder) {
    case 'Listed recently':
      return 'expiryDate desc';
    case 'Lowest price':
      return 'price asc';
    case 'Highest price':
      return 'price desc';
    case 'Oldest vehicles':
      return 'year asc';
    case 'Newest vehicles':
      return 'year desc';
    case 'Lowest kms':
      return 'odometer asc';
    case 'Highest kms':
      return 'odometer desc';
    case 'price asc':
      return 'price asc';
    case 'price desc':
      return 'price desc';
    case 'year asc':
      return 'year asc';
    case 'year desc':
      return 'year desc';
    case 'odometer asc':
      return 'odometer asc';
    case 'odometer desc':
      return 'odometer desc';
    default:
      return 'price asc';
  }
}

String getSortOrderKey(String value) {
  switch (value) {
    case 'price asc':
      return 'Lowest price';
    case 'price desc':
      return 'Highest price';
    case 'year asc':
      return 'Oldest vehicles';
    case 'year desc':
      return 'Newest vehicles';
    case 'odometer asc':
      return 'Lowest kms';
    case 'odometer desc':
      return 'Highest kms';
    case 'expiryDate desc':
      return 'Listed recently';
    default:
      return 'Lowest price';
  }
}
