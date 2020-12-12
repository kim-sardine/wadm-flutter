import 'package:intl/intl.dart';

class Messages {

  String get tooltipCreateNewWadm => Intl.message("Create wew wadm",
    name: "tooltipCreateNewWadm"
  );

  String get dialogLabelWadmTitle => Intl.message("Title",
    name: "dialogLabelWadmTitle"
  );
  String get dialogButtonCreate => Intl.message("Create",
    name: "dialogButtonCreate"
  );
  String get dialogButtonAdd => Intl.message("Add",
    name: "dialogButtonAdd"
  );
  String get dialogButtonDelete => Intl.message("Delete",
    name: "dialogButtonDelete"
  );
  String get dialogButtonDeleteWadm => Intl.message("Delete wadm",
    name: "dialogButtonDeleteWadm"
  );
  String get dialogButtonUpdate => Intl.message("Update",
    name: "dialogButtonUpdate"
  );
  String get dialogButtonUpdateWadmTitle => Intl.message("Change title",
    name: "dialogButtonUpdateWadmTitle"
  );
  String get dialogLabelCategoryTitle => Intl.message("Category Title",
    name: "dialogLabelCategoryTitle"
  );
  String get dialogLabelCategoryWeight => Intl.message("Weight (1~10)",
    name: "dialogLabelCategoryWeight"
  );
  String get dialogLabelCandidateTitle => Intl.message("Candidate Title",
    name: "dialogLabelCandidateTitle"
  );
  String get dialogTitleSelectAction => Intl.message("Choose the action you want",
    name: "dialogTitleSelectAction",
    desc: "원하는 동작을 선택해주세요",
  );
  String get dialogButtonAddCategory => Intl.message("Add new category",
    name: "dialogButtonAddCategory",
  );
  String get dialogButtonAddCandidate => Intl.message("Add new candidate",
    name: "dialogButtonAddCandidate",
  );

  String get widgetMessage => Intl.message("Widget Message!",
    name: "widgetMessage"
  );
}
