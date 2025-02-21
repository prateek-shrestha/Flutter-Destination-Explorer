import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Explore Nepal\'s Beautiful Destinations ';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(image: 'images/gufa.jpg'),
              TitleSection(
                name: 'Gufa Pokhari, The Pride of Sankhuwa-Sabha',
                location: 'Sankhuwa-Sabha, Nepal',
              ),
              ButtonSection(),
              TextSection(
                description:
                    'Gufa Pokhari, a natural pond in eastern Nepal’s Sankhuwasabha District... Gufa Pokhari is known for its serene environment, beautiful landscapes, and historical significance. It lies at an altitude of 2890 meters, providing stunning views of the Himalayas.\n\nSurrounded by rhododendron forests and home to diverse flora and fauna, the place is a paradise for nature lovers and trekkers. During the monsoon season, the pond reflects the clear blue sky, making it an ideal destination for photographers and tourists.\n\nThe local culture and traditions add to the charm, with several homestays available for visitors. The area is also popular for religious significance, with local myths and stories surrounding the pond.',
              ),
              ReviewSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.1),
          BlendMode.darken,
        ),
        child: Image.asset(
          image,
          width: double.infinity,
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.grey[500]),
          const Text('41'),
        ],
      ),
    );
  }
}

class ButtonSection extends StatefulWidget {
  const ButtonSection({super.key});
  @override
  _ButtonSectionState createState() => _ButtonSectionState();
}

class _ButtonSectionState extends State<ButtonSection> {
  bool isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    final Color color =
        Theme.of(context).primaryColor; // Use the same color as other buttons

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isWishlisted = !isWishlisted;
            });
          },
          child: ButtonWithText(
            color: color, // Now same color as ROUTE and SHARE
            icon: isWishlisted ? Icons.favorite : Icons.favorite_border,
            label: 'WISHLIST',
          ),
        ),
        ButtonWithText(color: color, icon: Icons.near_me, label: 'ROUTE'),
        ButtonWithText(color: color, icon: Icons.share, label: 'SHARE'),
      ],
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatefulWidget {
  const TextSection({super.key, required this.description});
  final String description;

  @override
  _TextSectionState createState() => _TextSectionState();
}

class _TextSectionState extends State<TextSection> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expanded
                ? widget.description
                : widget.description.substring(0, 150) + '...',
            softWrap: true,
            style: const TextStyle(fontSize: 16),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Text(expanded ? 'Read Less' : 'Read More'),
          ),
        ],
      ),
    );
  }
}

class ReviewSection extends StatefulWidget {
  const ReviewSection({super.key});

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  final List<Map<String, dynamic>> _reviews = [];
  final TextEditingController _controller = TextEditingController();
  int _selectedStars = 5;

  void _addReview() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _reviews.insert(0, {
          'comment': _controller.text,
          'stars': _selectedStars,
        });
        _controller.clear();
        _selectedStars = 5; // Reset stars to 5 after each comment
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a Review:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _selectedStars ? Icons.star : Icons.star_border,
                      color: Colors.yellow[700],
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedStars = index + 1;
                      });
                    },
                  );
                }),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Write your review...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addReview,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Text(
          'Reviews:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 200, // Set a fixed height for scrollable comments
          child: SingleChildScrollView(
            child: Column(
              children: _reviews.map((review) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(review['comment']),
                    subtitle: Row(
                      children: List.generate(
                        review['stars'],
                        (index) => const Icon(Icons.star, color: Colors.yellow),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
