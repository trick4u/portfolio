import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpertiseSection extends StatelessWidget {
  final List<ExpertiseCard> expertiseCards = [
    ExpertiseCard(
      title: "Core Development",
      subtitle: "FLUTTER, DART & MORE",
      description: "Flutter, Dart, Native Android, Cross-Platform Development",
    ),
    ExpertiseCard(
      title: "State Management",
      subtitle: "ARCHITECTURE & PATTERNS",
      description: "GetX, Provider, Bloc, Riverpod",
    ),
    ExpertiseCard(
      title: "Backend Integration",
      subtitle: "DATABASES & APIS",
      description: "Firebase Suite, RESTful APIs, SQLite, Cloud Firestore",
    ),
    ExpertiseCard(
      title: "Clean Code",
      subtitle: "PRINCIPLES & PATTERNS",
      description: "MVC, Clean Architecture, SOLID Principles",
    ),
    ExpertiseCard(
      title: "Quality Assurance",
      subtitle: "TESTING & DEPLOYMENT",
      description: "Unit Testing, Widget Testing, Integration Testing, CI/CD",
    ),
    ExpertiseCard(
      title: "UI/UX Design",
      subtitle: "FRONTEND EXPERTISE",
      description: "Custom Animations, Material Design, Responsive Layouts",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200
        ? 3
        : screenWidth > 800
            ? 2
            : 1;

    return Container(
      color: const Color(0xFF1A1A1A),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.5,
                ),
                itemCount: expertiseCards.length,
                itemBuilder: (context, index) =>
                    _buildCard(expertiseCards[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Technical Expertise',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(ExpertiseCard card) {
    return TiltCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF242424),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[400],
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              card.title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              card.description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[300],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class TiltCard extends StatefulWidget {
  final Widget child;

  const TiltCard({Key? key, required this.child}) : super(key: key);

  @override
  TiltCardState createState() => TiltCardState();
}

class TiltCardState extends State<TiltCard> {
  double x = 0.0;
  double y = 0.0;
  double borderValueY = 150.0;
  double borderValueX = 200.0;
  double beginY = 0.0;
  double endY = 0.0;
  double beginX = 0.0;
  double endX = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
        tween: Tween(begin: beginX, end: endX),
        builder: (context, valueX, child) => TweenAnimationBuilder(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: beginY, end: endY),
          builder: (context, valueY, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(valueX as double)
                ..rotateY(valueY as double),
              alignment: FractionalOffset.center,
              child: MouseRegion(
                onHover: (details) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final position = box.globalToLocal(details.position);
                  double yvalue = (box.size.width / 2) - position.dx;
                  double xvalue = (box.size.height / 2) - position.dy;

                  if (yvalue <= borderValueY && yvalue >= -borderValueY) {
                    setState(() {
                      double oldRange = (borderValueY - (-borderValueY));
                      double newRange = (0.35 - (-0.35));
                      double newValue =
                          (((yvalue - (-borderValueY)) * newRange) / oldRange) +
                              (-0.35);
                      beginY = y;
                      y = newValue;
                      endY = y;

                      oldRange = (borderValueX - (-borderValueX));
                      newRange = (0.35 - (-0.35));
                      newValue = (((-xvalue - (-borderValueX)) * newRange) /
                              oldRange) +
                          (-0.35);
                      beginX = x;
                      x = newValue;
                      endX = x;
                    });
                  }
                },
                onExit: (event) {
                  setState(() {
                    y = 0.0;
                    x = 0.0;
                    beginY = 0.0;
                    endY = 0.0;
                    beginX = 0.0;
                    endX = 0.0;
                  });
                },
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExpertiseCard {
  final String title;
  final String subtitle;
  final String description;

  ExpertiseCard({
    required this.title,
    required this.subtitle,
    required this.description,
  });
}
