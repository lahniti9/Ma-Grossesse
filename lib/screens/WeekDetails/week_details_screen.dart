import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/utils/colors.dart';
import 'package:pregnancy_tracker/screens/WeekDetails/advice_page.dart';
import 'package:pregnancy_tracker/screens/WeekDetails/empty_view.dart';
import 'package:pregnancy_tracker/screens/WeekDetails/error_view.dart';
import 'package:pregnancy_tracker/screens/WeekDetails/follow_up_page.dart';
import 'package:pregnancy_tracker/screens/WeekDetails/loading_view.dart';
import 'package:pregnancy_tracker/services/api_service.dart';

class WeekDetailsScreen extends StatefulWidget {
  final int week;

  const WeekDetailsScreen({super.key, required this.week});

  @override
  State<WeekDetailsScreen> createState() => _WeekDetailsScreenState();
}

class _WeekDetailsScreenState extends State<WeekDetailsScreen> {
  late Future<Map<String, dynamic>> _weekData;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _weekData = ApiService.getWeekDetails(widget.week, language: 'french');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semaine ${widget.week}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 248, 126, 166),
                const Color.fromARGB(255, 179, 39, 125),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _weekData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingView();
          }

          if (snapshot.hasError) {
            return buildErrorView(snapshot.error.toString(), () {
              setState(() {
                _weekData = ApiService.getWeekDetails(
                  widget.week,
                  language: 'french',
                );
              });
            });
          }

          if (!snapshot.hasData) {
            return buildEmptyView();
          }

          final weekData = snapshot.data!;
          return Column(
            children: [
              // Segmented Control
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightPink.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(
                      value: 0,
                      label: Text('Conseils'),
                      icon: Icon(Icons.medical_services_outlined, size: 20),
                    ),
                    ButtonSegment(
                      value: 1,
                      label: Text('Progrès'),
                      icon: Icon(Icons.track_changes_outlined, size: 20),
                    ),
                  ],
                  selected: {_currentPageIndex},
                  onSelectionChanged: (Set<int> newSelection) {
                    setState(() {
                      _currentPageIndex = newSelection.first;
                      _pageController.animateToPage(
                        _currentPageIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  style: SegmentedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    selectedBackgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.darkPink,
                    selectedForegroundColor: Colors.white,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              // Page View Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPageIndex = index);
                  },
                  children: [
                    buildAdvicePage(
                      weekData['advice'] ?? 'Aucun conseil disponible',
                      widget.week,
                    ),
                    buildFollowUpPage(
                      weekData['follow_up'] ?? 'Aucune information de progrès',
                      widget.week,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
