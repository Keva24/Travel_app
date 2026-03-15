import '../models/destination.dart';

const List<String> travelCategories = [
  'All',
  'Beach',
  'City',
  'Mountain',
  'Cultural',
  'Adventure',
];

const List<Destination> destinations = [
  Destination(
    id: '1',
    name: 'Paris',
    country: 'France',
    imageAsset: 'assets/images/paris.jpg',
    description:
        'Known as the "City of Light," Paris is one of the world\'s most visited cities, '
        'admired for its stunning architecture, world-class cuisine, and rich cultural heritage. '
        'From the iconic Eiffel Tower to the grand Louvre Museum, every corner of Paris tells a story.\n\n'
        'Stroll along the Seine River, explore charming neighborhoods like Montmartre, '
        'and indulge in freshly baked croissants at a sidewalk café. Paris is a city that '
        'effortlessly blends history, romance, and modernity.\n\n'
        'Whether you\'re visiting the Palace of Versailles, shopping on the Champs-Élysées, '
        'or catching a show at the Moulin Rouge, Paris promises an unforgettable experience '
        'that will leave you longing to return.',
    rating: 4.8,
    reviewCount: 3201,
    pricePerNight: 320.0,
    duration: '5 Days / 4 Nights',
    weather: 'Mild, 18°C',
    category: 'City',
    isFeatured: true,
  ),
  Destination(
    id: '2',
    name: 'Bali',
    country: 'Indonesia',
    imageAsset: 'assets/images/bali.jpg',
    description:
        'Bali, the Island of the Gods, is a magical destination that captivates travelers with its '
        'lush rice terraces, ancient temples, and warm hospitality. The island offers a perfect '
        'blend of spiritual culture, stunning natural beauty, and vibrant nightlife.\n\n'
        'Explore the sacred Tanah Lot temple perched on a rocky outcrop, or find your inner '
        'peace in the spiritual hub of Ubud. Surfers flock to Kuta and Seminyak for world-class '
        'waves, while Nusa Dua offers pristine white sand beaches.\n\n'
        'Bali\'s unique Hindu culture permeates every aspect of life — from elaborate temple '
        'ceremonies to intricate woodcarvings and traditional Kecak dance performances. '
        'This island paradise truly has something for every type of traveler.',
    rating: 4.9,
    reviewCount: 5820,
    pricePerNight: 185.0,
    duration: '7 Days / 6 Nights',
    weather: 'Tropical, 29°C',
    category: 'Beach',
    isFeatured: true,
  ),
  Destination(
    id: '3',
    name: 'Maldives',
    country: 'Maldives',
    imageAsset: 'assets/images/maldives.jpg',
    description:
        'The Maldives is the ultimate luxury tropical escape, comprising over 1,000 coral islands '
        'scattered across the Indian Ocean. Its crystal-clear turquoise lagoons, vibrant coral '
        'reefs, and overwater bungalows make it one of the most sought-after destinations on Earth.\n\n'
        'Snorkel or dive alongside manta rays, whale sharks, and colorful reef fish in some of '
        'the world\'s most pristine waters. Relax in your private overwater villa as the gentle '
        'ocean breeze carries the scent of tropical flowers.\n\n'
        'Whether you\'re celebrating a honeymoon, anniversary, or simply treating yourself to '
        'the finest in luxury travel, the Maldives delivers an experience of unparalleled '
        'serenity and natural beauty that will stay with you forever.',
    rating: 4.9,
    reviewCount: 2145,
    pricePerNight: 850.0,
    duration: '6 Days / 5 Nights',
    weather: 'Sunny, 30°C',
    category: 'Beach',
    isFeatured: true,
  ),
  Destination(
    id: '4',
    name: 'Tokyo',
    country: 'Japan',
    imageAsset: 'assets/images/tokyo.jpg',
    description:
        'Tokyo is a city that seamlessly merges the ultramodern with the traditional, '
        'offering an endlessly fascinating urban experience. From towering skyscrapers and '
        'neon-lit streets to serene temples and tranquil gardens, Tokyo is a city of contrasts.\n\n'
        'Explore the bustling districts of Shibuya and Shinjuku, discover the anime and manga '
        'culture of Akihabara, or find tranquility in the imperial gardens near the Imperial '
        'Palace. Tokyo\'s food scene is legendary — from ramen and sushi to Michelin-starred '
        'kaiseki dining.\n\n'
        'The city\'s efficiency, cleanliness, and the extraordinary politeness of its residents '
        'make it one of the most livable and visitable cities in the world. Tokyo is a place '
        'that rewards curious exploration at every turn.',
    rating: 4.7,
    reviewCount: 4103,
    pricePerNight: 210.0,
    duration: '8 Days / 7 Nights',
    weather: 'Temperate, 22°C',
    category: 'City',
    isFeatured: false,
  ),
  Destination(
    id: '5',
    name: 'Santorini',
    country: 'Greece',
    imageAsset: 'assets/images/santorini.jpg',
    description:
        'Santorini is perhaps the most iconic of all the Greek islands, famous for its dramatic '
        'caldera views, white-washed buildings with blue domed rooftops, and spectacular sunsets '
        'over the Aegean Sea. This crescent-shaped volcanic island is a feast for the eyes.\n\n'
        'The village of Oia is celebrated worldwide for offering the most breathtaking sunset '
        'views in the Mediterranean. Explore the ancient ruins of Akrotiri, swim in the '
        'volcanic hot springs, or simply sip local wine on your terrace as the sun dips below '
        'the horizon in a blaze of gold and crimson.\n\n'
        'Santorini\'s unique geology, excellent cuisine featuring fresh seafood and local '
        'delicacies, and warm Aegean climate make it an ideal destination for romance, '
        'relaxation, and cultural discovery.',
    rating: 4.8,
    reviewCount: 3756,
    pricePerNight: 390.0,
    duration: '5 Days / 4 Nights',
    weather: 'Sunny, 25°C',
    category: 'Cultural',
    isFeatured: true,
  ),
  Destination(
    id: '6',
    name: 'New York',
    country: 'USA',
    imageAsset: 'assets/images/new_york.jpg',
    description:
        'New York City is the city that never sleeps — a global metropolis that pulses with '
        'energy, creativity, and ambition 24 hours a day. The iconic skyline, featuring the '
        'Empire State Building and One World Trade Center, is recognized the world over.\n\n'
        'Explore the vast collections of the Metropolitan Museum of Art, take a stroll through '
        'the oasis of Central Park, or catch a Broadway show in the Theater District. The city\'s '
        'five boroughs each offer a distinct character and a world of culinary diversity.\n\n'
        'From the bright lights of Times Square to the hip galleries of Chelsea, the trendy '
        'boutiques of SoHo, and the authentic neighborhoods of Brooklyn, New York City is '
        'an experience that overwhelms the senses in the most exhilarating way possible.',
    rating: 4.6,
    reviewCount: 6890,
    pricePerNight: 450.0,
    duration: '6 Days / 5 Nights',
    weather: 'Variable, 15°C',
    category: 'City',
    isFeatured: false,
  ),
];
