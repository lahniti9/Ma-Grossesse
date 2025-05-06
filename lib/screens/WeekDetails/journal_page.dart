import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracker/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildJournalPage(int week) {
  return _JournalPageContent(week: week);
}

class _JournalPageContent extends StatefulWidget {
  final int week;

  const _JournalPageContent({required this.week});

  @override
  State<_JournalPageContent> createState() => _JournalPageContentState();
}

class _JournalPageContentState extends State<_JournalPageContent> {
  final TextEditingController _noteController = TextEditingController();
  List<Map<String, String>> _savedNotes = [];
  bool _isNoteSaved = false;
  int? _editingNoteIndex;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList('week_${widget.week}_notes') ?? [];
    setState(() {
      _savedNotes =
          notesJson
              .map((note) => Map<String, String>.from(json.decode(note)))
              .toList();
    });
  }

  Future<void> _saveNote() async {
    if (_noteController.text.isEmpty) return;

    final newNote = {
      'text': _noteController.text,
      'date': DateTime.now().toIso8601String(),
      'week': widget.week.toString(),
    };

    final prefs = await SharedPreferences.getInstance();

    if (_editingNoteIndex != null) {
      _savedNotes[_editingNoteIndex!] = newNote;
    } else {
      _savedNotes.add(newNote);
    }

    await prefs.setStringList(
      'week_${widget.week}_notes',
      _savedNotes.map((note) => json.encode(note)).toList(),
    );

    setState(() {
      _isNoteSaved = true;
      _noteController.clear();
      _editingNoteIndex = null;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isNoteSaved = false);
    });
  }

  Future<void> _deleteNote(int index) async {
    final prefs = await SharedPreferences.getInstance();
    _savedNotes.removeAt(index);
    await prefs.setStringList(
      'week_${widget.week}_notes',
      _savedNotes.map((note) => json.encode(note)).toList(),
    );
    setState(() {});
  }

  void _editNote(int index) {
    setState(() {
      _editingNoteIndex = index;
      _noteController.text = _savedNotes[index]['text']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Note Input Section - Modern Card Design
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.edit_note, color: AppColors.darkPink, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    _editingNoteIndex != null
                        ? 'Modifier la note'
                        : 'Nouvelle entrée',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkPink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Comment vous sentez-vous cette semaine ?',
                  filled: true,
                  // ignore: deprecated_member_use
                  fillColor: AppColors.lightPink.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: AppColors.darkPink.withOpacity(0.4),
                  ),
                ),
                style: TextStyle(color: Colors.black87, fontSize: 15),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveNote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        // ignore: deprecated_member_use
                        shadowColor: AppColors.primaryColor.withOpacity(0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isNoteSaved ? Icons.check : Icons.save,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isNoteSaved
                                ? _editingNoteIndex != null ? 'Modifié' : 'Enregistré'
                                : _editingNoteIndex != null
                                ? 'Modifier'
                                : 'Enregistrer',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_editingNoteIndex != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _noteController.clear();
                            _editingNoteIndex = null;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          side: BorderSide(
                            color: AppColors.primaryColor,
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close, size: 20),
                            const SizedBox(width: 8),
                            const Text('Annuler'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),

        // Notes List Section
        Expanded(
          child:
              _savedNotes.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          size: 72,
                          // ignore: deprecated_member_use
                          color: AppColors.softPink.withOpacity(0.2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Votre journal est vide',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkPink,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Commencez à documenter votre parcours\nen ajoutant votre première note',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkPink.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: _savedNotes.length,
                    itemBuilder: (context, index) {
                      final note = _savedNotes[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => _editNote(index),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: AppColors.lightPink,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.edit_note,
                                          size: 18,
                                          color: AppColors.darkPink,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              note['text']!,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87,
                                                height: 1.4,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              DateFormat(
                                                'dd MMMM yyyy - HH:mm',
                                                'fr_FR',
                                              ).format(
                                                DateTime.parse(note['date']!),
                                              ),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.darkPink
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.grey[500],
                                          size: 22,
                                        ),
                                        onPressed: () async {
                                          final shouldDelete = await showDialog(
                                            context: context,
                                            builder:
                                                (context) => AlertDialog(
                                                  title: Text(
                                                    'Supprimer la note?',
                                                    style: TextStyle(
                                                      color: AppColors.darkPink,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Cette action ne peut pas être annulée',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.of(
                                                            context,
                                                          ).pop(false),
                                                      child: Text(
                                                        'Annuler',
                                                        style: TextStyle(
                                                          color:
                                                              AppColors
                                                                  .darkPink,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.of(
                                                            context,
                                                          ).pop(true),
                                                      child: Text(
                                                        'Supprimer',
                                                        style: TextStyle(
                                                          color:
                                                              AppColors
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                ),
                                          );
                                          if (shouldDelete == true) {
                                            _deleteNote(index);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
