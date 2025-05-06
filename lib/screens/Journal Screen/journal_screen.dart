import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/utils/colors.dart';
import 'journal_entry_card.dart';
import 'journal_entry_dialog.dart';
import 'journal_empty_state.dart';
import 'journal_repository.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final JournalRepository _repository = JournalRepository();
  final TextEditingController _noteController = TextEditingController();
  List<Map<String, String>> journalEntries = [];

  @override
  void initState() {
    super.initState();
    _loadJournalEntries();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadJournalEntries() async {
    final entries = await _repository.loadEntries();
    setState(() => journalEntries = entries);
  }

  Future<void> _saveJournalEntries() async {
    await _repository.saveEntries(journalEntries);
  }

  void _addNewEntry(String content) {
    setState(() {
      journalEntries.insert(0, {
        'date': DateTime.now().toIso8601String(),
        'content': content,
      });
    });
    _saveJournalEntries();
  }

  void _updateEntry(int index, String newContent) {
    setState(() {
      journalEntries[index]['content'] = newContent;
      journalEntries[index]['date'] = DateTime.now().toIso8601String();
    });
    _saveJournalEntries();
  }

  void _deleteEntry(int index) {
    setState(() => journalEntries.removeAt(index));
    _saveJournalEntries();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Note supprimée"),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showAddEntryDialog() {
    _noteController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => JournalEntryDialog(
            controller: _noteController,
            isEditing: false,
            onSave: () {
              if (_noteController.text.isNotEmpty) {
                _addNewEntry(_noteController.text);
                Navigator.pop(context);
              }
            },
          ),
    );
  }

  void _showEditEntryDialog(int index) {
    _noteController.text = journalEntries[index]['content']!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => JournalEntryDialog(
            controller: _noteController,
            isEditing: true,
            onSave: () {
              _updateEntry(index, _noteController.text);
              Navigator.pop(context);
            },
            onDelete: () async {
              final shouldDelete = await showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text("Supprimer la note"),
                      content: const Text(
                        "Voulez-vous vraiment supprimer cette note définitivement ?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Annuler"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(
                            "Supprimer",
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ),
                      ],
                    ),
              );
              if (shouldDelete == true) {
                _deleteEntry(index);
                Navigator.pop(context);
              }
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Journal de Grossesse',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
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
                color: Colors.purple.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 28,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightPink, Colors.white],
          ),
        ),
        child:
            journalEntries.isEmpty
                ? JournalEmptyState(onAddEntry: _showAddEntryDialog)
                : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: AppColors.darkPink,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Vos notes récentes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkPink,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: journalEntries.length,
                        itemBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                              child: JournalEntryCard(
                                entry: journalEntries[index],
                                onEdit: () => _showEditEntryDialog(index),
                                onDelete: () => _deleteEntry(index),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntryDialog,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.edit_note_rounded, size: 28),
      ),
    );
  }
}
