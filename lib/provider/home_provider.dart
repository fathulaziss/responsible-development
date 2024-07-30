import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsible_development/database/activity_database.dart';
import 'package:responsible_development/database/my_project_database.dart';
import 'package:responsible_development/database/user_database.dart';
import 'package:responsible_development/models/my_project_model.dart';
import 'package:responsible_development/widgets/others/loading_indicator.dart';

class HomeProvider extends ChangeNotifier {
  List<MyProjectModel> _listMyProject = [];

  List<MyProjectModel> get listMyProject => _listMyProject;

  MyProjectModel _selectedProject = const MyProjectModel();

  MyProjectModel get selectedProject => _selectedProject;

  List<String> _listPeriode = [];

  List<String> get listPeriode => _listPeriode;

  String _selectedPeriode = '';

  String get selectedPeriode => _selectedPeriode;

  double _totalAktualJamKontribusi = 0;

  double get totalAktualJamKontribusi => _totalAktualJamKontribusi;

  double _averageAktualJamKontribusi = 0;

  double get averageAktualJamKontribusi => _averageAktualJamKontribusi;

  double _aktualJamKontribusiJanuari = 0;

  double get aktualJamKontribusiJanuari => _aktualJamKontribusiJanuari;

  double _aktualJamKontribusiFebruari = 0;

  double get aktualJamKontribusiFebruari => _aktualJamKontribusiFebruari;

  double _aktualJamKontribusiMaret = 0;

  double get aktualJamKontribusiMaret => _aktualJamKontribusiMaret;

  double _aktualJamKontribusiApril = 0;

  double get aktualJamKontribusiApril => _aktualJamKontribusiApril;

  double _aktualJamKontribusiMei = 0;

  double get aktualJamKontribusiMei => _aktualJamKontribusiMei;

  double _aktualJamKontribusiJuni = 0;

  double get aktualJamKontribusiJuni => _aktualJamKontribusiJuni;

  double _aktualJamKontribusiJuli = 0;

  double get aktualJamKontribusiJuli => _aktualJamKontribusiJuli;

  double _aktualJamKontribusiAgustus = 0;

  double get aktualJamKontribusiAgustus => _aktualJamKontribusiAgustus;

  double _aktualJamKontribusiSeptember = 0;

  double get aktualJamKontribusiSeptember => _aktualJamKontribusiSeptember;

  double _aktualJamKontribusiOktober = 0;

  double get aktualJamKontribusiOktober => _aktualJamKontribusiOktober;

  double _aktualJamKontribusiNovember = 0;

  double get aktualJamKontribusiNovember => _aktualJamKontribusiNovember;

  double _aktualJamKontribusiDesember = 0;

  double get aktualJamKontribusiDesember => _aktualJamKontribusiDesember;

  Future<void> getMyProject(BuildContext context) async {
    if (_listMyProject.isEmpty) {
      context.loaderOverlay.show(
        widgetBuilder: (progress) => const LoadingIndicatorDefault(),
      );

      final user = await UserDatabase.selectData();
      final data = await MyProjectDatabase.selectData(user);
      _listMyProject = data;

      if (_listMyProject.isNotEmpty) {
        setSelectedProject(_listMyProject.first);
      }

      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();

      if (context.mounted) {
        context.loaderOverlay.hide();
      }
    }
  }

  Future<void> getActivityHistoryData() async {
    _totalAktualJamKontribusi = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
    );
    _averageAktualJamKontribusi = _totalAktualJamKontribusi / 12;
    _aktualJamKontribusiJanuari = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Januari',
    );
    _aktualJamKontribusiFebruari = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Februari',
    );
    _aktualJamKontribusiMaret = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Maret',
    );
    _aktualJamKontribusiApril = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'April',
    );
    _aktualJamKontribusiMei = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Mei',
    );
    _aktualJamKontribusiJuni = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Juni',
    );
    _aktualJamKontribusiJuli = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Juli',
    );
    _aktualJamKontribusiAgustus = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Agustus',
    );
    _aktualJamKontribusiSeptember = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'September',
    );
    _aktualJamKontribusiOktober = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Oktober',
    );
    _aktualJamKontribusiNovember = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'November',
    );
    _aktualJamKontribusiDesember = await ActivityDatabase.selectDataSummary(
      projectName: selectedProject.project?.name ?? '',
      periode: selectedPeriode,
      monthPeriode: 'Desember',
    );
    notifyListeners();
  }

  void setSelectedProject(Object? value) {
    if (value != null) {
      final data = value as MyProjectModel;
      _selectedProject = data;
      log('check data : ${_selectedProject.project}');
      _listPeriode = data.project?.periode ?? [];
      if (_listPeriode.isNotEmpty) {
        _selectedPeriode = _listPeriode.last;
        getActivityHistoryData();
      }
      notifyListeners();
    }
  }

  void setSelectedPeriode(Object? value) {
    if (value != null) {
      final data = value as String;
      _selectedPeriode = data;
      getActivityHistoryData();
      notifyListeners();
    }
  }
}
