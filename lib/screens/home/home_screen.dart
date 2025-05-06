// home_screen.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/utils/colors.dart';
import 'package:pregnancy_tracker/screens/help_screen.dart';
import 'package:pregnancy_tracker/screens/home/WeekCard.dart';
import 'package:pregnancy_tracker/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/pregnancy_progress_header.dart';
import 'widgets/search_field.dart';
import 'widgets/no_internet_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<int> allWeeks = List.generate(40, (index) => index + 1);
  List<int> displayedWeeks = [];
  String searchQuery = "";
  int? currentWeek;
  bool _isOnline = true;
  DateTime? _lastPeriodDate;
  int _daysSinceFirstUse = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    displayedWeeks = allWeeks;
    _initializeDateFormatting();
    _loadFirstUseDate().then((_) => _updateProgress());
    _checkInternetConnection();
    _loadLastPeriodDate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateProgress();
    }
  }

  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting('fr_FR');
  }

  Future<void> _updateProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final firstUseDateStr = prefs.getString('firstUseDate');
    final savedWeek = prefs.getInt('currentWeek');

    if (savedWeek != null) {
      setState(() {
        currentWeek = savedWeek;
      });
      return;
    }

    if (firstUseDateStr != null) {
      final firstUseDate = DateTime.parse(firstUseDateStr);
      final daysPassed = DateTime.now().difference(firstUseDate).inDays;
      final weeksPassed = (daysPassed / 7).floor();
      final calculatedWeek = (weeksPassed + 1).clamp(1, 40);

      setState(() {
        _daysSinceFirstUse = daysPassed;
        currentWeek = calculatedWeek;
      });

      await prefs.setInt('currentWeek', calculatedWeek);
    }
  }

  Future<void> _loadFirstUseDate() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('firstUseDate');

    if (savedDate == null) {
      final now = DateTime.now();
      await prefs.setString('firstUseDate', now.toIso8601String());
      setState(() {
        _daysSinceFirstUse = 0;
        currentWeek = 1;
      });
    } else {
      setState(() {});
    }
  }

  Future<void> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<void> _loadLastPeriodDate() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('lastPeriodDate');
    final savedWeek = prefs.getInt('currentWeek');

    if (savedDate != null) {
      setState(() {
        _lastPeriodDate = DateTime.parse(savedDate);
        if (savedWeek != null) {
          currentWeek = savedWeek;
        } else {
          _calculateDueDate();
        }
      });
    }
  }

  Future<void> _saveLastPeriodDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastPeriodDate', date.toIso8601String());
  }

  void _calculateDueDate() {
    if (_lastPeriodDate != null) {
      setState(() {
        currentWeek = _calculateCurrentWeek();
      });
    }
  }

  int _calculateCurrentWeek() {
    if (_lastPeriodDate == null) return 1;

    final today = DateTime.now();
    final difference = today.difference(_lastPeriodDate!).inDays;
    final weeks = (difference / 7).floor() + 1;

    return weeks.clamp(1, 40);
  }

  Future<void> _selectLastPeriodDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _lastPeriodDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.darkPink,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _lastPeriodDate) {
      final newWeek = _calculateCurrentWeekFromDate(picked);
      setState(() {
        _lastPeriodDate = picked;
        currentWeek = newWeek;
      });
      await _saveLastPeriodDate(picked);
      await _saveCurrentWeek(newWeek);
    }
  }

  int _calculateCurrentWeekFromDate(DateTime date) {
    final today = DateTime.now();
    final difference = today.difference(date).inDays;
    final weeks = (difference / 7).floor() + 1;
    return weeks.clamp(1, 40);
  }

  void filterWeeks(String query) {
    setState(() {
      searchQuery = query;
      displayedWeeks =
          query.isEmpty
              ? allWeeks
              : allWeeks
                  .where((week) => week.toString().contains(query))
                  .toList();
    });
  }

  Future<void> _saveCurrentWeek(int week) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentWeek', week);
  }

  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.lightPink, Colors.white],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.settings, color: AppColors.primaryColor),
                ),
                title: Text(
                  'Paramètres',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkPink,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Colors.black12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.help_outline,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: Text(
                  'Aide et support',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkPink,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeekGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: displayedWeeks.length,
      itemBuilder:
          (ctx, index) => WeekCard(
            week: displayedWeeks[index],
            isCurrent: displayedWeeks[index] == currentWeek,
            primaryColor: AppColors.primaryColor,
            secondaryColor: AppColors.secondaryColor,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnline) {
      return NoInternetWidget(onRetry: _checkInternetConnection);
    }

    return Scaffold(
      backgroundColor: AppColors.lightPink,
      appBar: CustomAppBar(
        currentWeek: currentWeek,
        onDatePressed: () => _selectLastPeriodDate(context),
        onSettingsPressed: () => _showSettingsMenu(context),
      ),
      body: Column(
        children: [
          PregnancyProgressHeader(
            currentWeek: currentWeek,
            daysSinceFirstUse: _daysSinceFirstUse,
          ),
          SearchField(onChanged: filterWeeks, searchQuery: searchQuery),
          Expanded(child: _buildWeekGrid()),
        ],
      ),
    );
  }
}
