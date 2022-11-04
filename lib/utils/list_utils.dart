import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ListUtils {
  static List<Map<String, dynamic>> drawerList = [
    {
      "icon": ImageUtils.appointmentsIcon,
      "title": StringUtils.appointment,
    },
    {
      "icon": ImageUtils.billsIcon,
      "title": StringUtils.bills,
    },
    {
      "icon": ImageUtils.diagnosisTestIcon,
      "title": StringUtils.diagnosisTests,
    },
    {
      "icon": ImageUtils.documentIcon,
      "title": StringUtils.documents,
    },
    {
      "icon": ImageUtils.noticeIcon,
      "title": StringUtils.noticeBoards,
    },
    {
      "icon": ImageUtils.invoiceIcon,
      "title": StringUtils.invoices,
    },
    {
      "icon": ImageUtils.liveConsIcon,
      "title": StringUtils.liveConsultations,
    },
    {
      "icon": ImageUtils.patientCaseIcon,
      "title": StringUtils.patientsCases,
    },
    {
      "icon": ImageUtils.patientAdmissionIcon,
      "title": StringUtils.patientAdmissions,
    },
    {
      "icon": ImageUtils.prescriptionIcon,
      "title": StringUtils.prescriptions,
    },
    {
      "icon": ImageUtils.vaccinatedIcon,
      "title": StringUtils.vaccinatedPatients,
    },
  ];
}
