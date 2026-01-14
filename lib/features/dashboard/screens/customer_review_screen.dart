import 'package:flutter/material.dart';

class CustomerReviewScreen extends StatelessWidget {
  const CustomerReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Reviews'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reviews.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ReviewCard(review: reviews[index]);
        },
      ),
    );
  }
}

final List<Review> reviews = const [
  Review(
    title: 'We had a lovely time for our dinner',
    name: 'Sharon Ngan',
    description:
        'We had a lovely time for our dinner. We ordered bhutuwa curry and lamb tikka masala which are tasty with different spice x I love the hospitality here as staff are very helpful and nice x Reasonable price xx We would definitely come back x What a hidden gem in South Wigston',
    created: '11 months ago',
  ),
  Review(
    title:
        'One of the best restaurants we have ever been to, all the staff were amazing',
    name: 'Hazel Moxon',
    description:
        'One of the best restaurants we have ever been to, all the staff were amazing and so thoughtful. The food was incredible and so reasonably priced, we were shocked that we were the only table but we definitely will be returning! Thank you for a great night',
    created: '11 months ago',
  ),
  Review(
    title: 'A Culinary Delight at Gorkha 8848',
    name: 'Pratiksha sharma',
    description:
        'If you&rsquo;re craving exceptional flavors, Gorkha 8848 is a must-visit! I had the pleasure of trying their Chicken Tikka Masala and an Indo-Chinese dish, and both were absolutely mind-blowing. The Chicken Tikka Masala had a perfect balance of spices, rich and creamy with tender, marinated chicken that melted in my mouth. It was a true delight for the taste buds, embodying authentic flavors with a modern twist. The Indo-Chinese dish, on the other hand, was an explosion of bold flavors. The balance of tangy, spicy, and savory notes, combined with fresh ingredients and impeccable presentation, left me thoroughly impressed. The staff at Gorkha 8848 are friendly, attentive, and make the experience even more enjoyable. The ambiance of the restaurant is cozy, reflecting a harmonious blend of Nepalese culture and modern elegance. Highly recommend Gorkha 8848 for anyone looking for a taste of culinary excellence! &nbsp;',
    created: '11 months ago',
  ),
  Review(
    title: 'Excellent service. Highly recommend',
    name: 'punte production',
    description:
        'The lamb chops were perfectly cooked, and the flavor was simply amazing. The staff were friendly and attentive, making the experience even better. The mix grill and Gorkha curry were absolutely mind-blowing&mdash;an unforgettable combination of flavors! We will definitely be coming back to Gorkha 8848 for more of their delicious food and excellent service. Highly recommend &nbsp;',
    created: '11 months ago',
  ),
  Review(
    title: 'The food was fresh and delicious with good service',
    name: 'Raman Mishra',
    description:
        'The food was fresh and delicious with good service. The Nepalese dishes were tasty and we loved it. This is a nice place to visit with friends and family. Chicken Bhutuwa and Momos are the best. &nbsp;',
    created: '11 months ago',
  ),
];

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              review.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              review.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                review.created,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String title;
  final String name;
  final String description;
  final String created;

  const Review({
    required this.title,
    required this.name,
    required this.description,
    required this.created,
  });
}
