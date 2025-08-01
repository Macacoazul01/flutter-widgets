import 'dart:ui';

import '../../interfaces/pdf_interface.dart';
import '../annotations/enum.dart';
import '../graphics/brushes/pdf_solid_brush.dart';
import '../graphics/fonts/pdf_font.dart';
import '../graphics/fonts/pdf_string_format.dart';
import '../graphics/pdf_pen.dart';
import '../io/pdf_constants.dart';
import '../io/pdf_cross_table.dart';
import '../pages/pdf_page.dart';
import '../pages/pdf_page_collection.dart';
import '../pdf_document/pdf_document.dart';
import '../primitives/pdf_array.dart';
import '../primitives/pdf_dictionary.dart';
import '../primitives/pdf_name.dart';
import '../primitives/pdf_reference.dart';
import '../primitives/pdf_reference_holder.dart';
import '../primitives/pdf_string.dart';
import 'enum.dart';
import 'pdf_check_box_field.dart';
import 'pdf_field.dart';
import 'pdf_field_item_collection.dart';
import 'pdf_form.dart';

/// Represents base class for field's group items.
class PdfFieldItem {
  //Constructor
  /// Initializes a new instance of the [PdfFieldItem] class.
  PdfFieldItem._(PdfField field, int index, PdfDictionary? dictionary) {
    _helper = PdfFieldItemHelper(this, field);
    _helper._collectionIndex = index;
    _helper.dictionary = dictionary;
  }

  //Field
  late PdfFieldItemHelper _helper;
  PdfPage? _page;

  //Properties
  /// Gets or sets the bounds.
  Rect get bounds {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(_helper.field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _helper._collectionIndex;
    final Rect rect = _helper.field.bounds;
    helper.defaultIndex = backUpIndex;
    return rect;
  }

  set bounds(Rect value) {
    if (value.isEmpty) {
      ArgumentError("bounds can't be null/empty");
    }
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(_helper.field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _helper._collectionIndex;
    _helper.field.bounds = value;
    helper.defaultIndex = backUpIndex;
  }

  /// Gets the page of the field.
  PdfPage? get page {
    if (_page == null) {
      final PdfFieldHelper helper = PdfFieldHelper.getHelper(_helper.field);
      final int backUpIndex = helper.defaultIndex;
      helper.defaultIndex = _helper._collectionIndex;
      _page = _helper.field.page;
      final PdfName pName = PdfName(PdfDictionaryProperties.p);
      final PdfArray? kids = helper.kids;
      if (kids != null && kids.count > 0) {
        final PdfCrossTable crosstable = helper.crossTable!;
        final PdfDocument? doc = crosstable.document;
        if (doc != null && PdfDocumentHelper.getHelper(doc).isLoadedDocument) {
          if (_helper.dictionary!.containsKey(pName)) {
            final IPdfPrimitive? pageRef = crosstable.getObject(
              _helper.dictionary![PdfDictionaryProperties.p],
            );
            if (pageRef != null && pageRef is PdfDictionary) {
              final PdfReference widgetReference = crosstable.getReference(
                _helper.dictionary,
              );
              for (int i = 0; i < doc.pages.count; i++) {
                final PdfPage loadedPage = doc.pages[i];
                final PdfArray? lAnnots =
                    PdfPageHelper.getHelper(loadedPage).obtainAnnotations();
                if (lAnnots != null) {
                  for (int i = 0; i < lAnnots.count; i++) {
                    final IPdfPrimitive? holder = lAnnots[i];
                    if (holder != null &&
                        holder is PdfReferenceHolder &&
                        holder.reference != null &&
                        holder.reference!.objNum == widgetReference.objNum &&
                        holder.reference!.genNum == widgetReference.genNum) {
                      _page = PdfPageCollectionHelper.getHelper(
                        doc.pages,
                      ).getPage(pageRef);
                      helper.defaultIndex = backUpIndex;
                      return _page;
                    }
                  }
                }
                if (_helper.dictionary!.containsKey(
                  PdfDictionaryProperties.p,
                )) {
                  final IPdfPrimitive? itemPageDict = PdfCrossTable.dereference(
                    _helper.dictionary![PdfDictionaryProperties.p],
                  );
                  final PdfDictionary pageDict =
                      PdfPageHelper.getHelper(loadedPage).dictionary!;
                  if (itemPageDict is PdfDictionary &&
                      itemPageDict == pageDict) {
                    _page = loadedPage;
                    helper.defaultIndex = backUpIndex;
                    return _page;
                  }
                }
              }
              helper.defaultIndex = backUpIndex;
              _page = null;
            }
          } else {
            final PdfReference widgetReference = crosstable.getReference(
              _helper.dictionary,
            );
            for (int i = 0; i < doc.pages.count; i++) {
              final PdfPage loadedPage = doc.pages[i];
              final PdfArray? lAnnots =
                  PdfPageHelper.getHelper(loadedPage).obtainAnnotations();
              if (lAnnots != null) {
                for (int i = 0; i < lAnnots.count; i++) {
                  final IPdfPrimitive? holder = lAnnots[i];
                  if (holder != null &&
                      holder is PdfReferenceHolder &&
                      holder.reference!.objNum == widgetReference.objNum &&
                      holder.reference!.genNum == widgetReference.genNum) {
                    return _page = loadedPage;
                  }
                }
              }
            }
            _page = null;
          }
        }
      }
      helper.defaultIndex = backUpIndex;
    }
    return _page;
  }
}

/// [PdfFieldItem] helper
class PdfFieldItemHelper {
  /// internal constructor
  PdfFieldItemHelper(this.fieldItem, this.field);

  /// internal field
  late PdfFieldItem fieldItem;

  /// internal field
  late PdfField field;

  /// internal field
  PdfDictionary? dictionary;

  /// internal field
  int _collectionIndex = 0;

  /// internal method
  PdfPen? get borderPen {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final PdfPen? pen = helper.borderPen;
    helper.defaultIndex = backUpIndex;
    return pen;
  }

  /// internal method
  PdfBorderStyle? get borderStyle {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final PdfBorderStyle bs = helper.borderStyle;
    helper.defaultIndex = backUpIndex;
    return bs;
  }

  /// internal method
  int get borderWidth {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final int borderWidth = helper.borderWidth;
    helper.defaultIndex = backUpIndex;
    return borderWidth;
  }

  /// internal method
  PdfStringFormat? get format {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final PdfStringFormat? sFormat = helper.format;
    helper.defaultIndex = backUpIndex;
    return sFormat;
  }

  /// internal method
  PdfBrush? get backBrush {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final PdfBrush? backBrush = helper.backBrush;
    helper.defaultIndex = backUpIndex;
    return backBrush;
  }

  /// internal method
  PdfBrush? get foreBrush {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final PdfBrush? foreBrush = helper.foreBrush;
    helper.defaultIndex = backUpIndex;
    return foreBrush;
  }

  /// internal method
  PdfBrush? get shadowBrush {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final PdfBrush? shadowBrush = helper.shadowBrush;
    helper.defaultIndex = backUpIndex;
    return shadowBrush;
  }

  /// internal method
  PdfFont get font {
    final PdfFieldHelper helper = PdfFieldHelper.getHelper(field);
    final int backUpIndex = helper.defaultIndex;
    helper.defaultIndex = _collectionIndex;
    final PdfFont font = helper.font!;
    helper.defaultIndex = backUpIndex;
    return font;
  }

  /// internal method
  static PdfFieldItemHelper getHelper(PdfFieldItem item) {
    return item._helper;
  }

  /// internal method
  bool obtainCheckedStatus() {
    bool check = false;
    IPdfPrimitive? state;
    if (dictionary!.containsKey(PdfDictionaryProperties.usageApplication)) {
      state = PdfCrossTable.dereference(
        dictionary![PdfDictionaryProperties.usageApplication],
      );
    }
    if (state == null) {
      final PdfFieldHelper fieldHelper = PdfFieldHelper.getHelper(field);
      final IPdfPrimitive? name = PdfFieldHelper.getValue(
        fieldHelper.dictionary!,
        fieldHelper.crossTable,
        PdfDictionaryProperties.v,
        false,
      );
      if (name != null && name is PdfName) {
        check =
            (name.name ==
                fieldHelper.getItemValue(dictionary!, fieldHelper.crossTable));
      }
    } else if (state is PdfName) {
      check = (state.name != PdfDictionaryProperties.off);
    }
    return check;
  }

  /// internal method
  void setCheckedStatus(bool check) {
    final PdfFieldHelper fieldHelper = PdfFieldHelper.getHelper(field);
    String? val = fieldHelper.getItemValue(dictionary!, fieldHelper.crossTable);
    if (val != null) {
      _uncheckOthers(val, check, fieldHelper);
    }
    if (check) {
      if (val == null || val.isEmpty) {
        val = PdfDictionaryProperties.yes;
      }
      fieldHelper.dictionary!.setName(PdfName(PdfDictionaryProperties.v), val);
      dictionary!.setProperty(
        PdfDictionaryProperties.usageApplication,
        PdfName(val),
      );
      dictionary!.setProperty(PdfDictionaryProperties.v, PdfName(val));
    } else {
      IPdfPrimitive? v;
      if (fieldHelper.dictionary!.containsKey(PdfDictionaryProperties.v)) {
        v = PdfCrossTable.dereference(
          fieldHelper.dictionary![PdfDictionaryProperties.v],
        );
      }
      if (v != null && v is PdfName && val == v.name) {
        fieldHelper.dictionary!.remove(PdfDictionaryProperties.v);
      }
      dictionary!.setProperty(
        PdfDictionaryProperties.usageApplication,
        PdfName(PdfDictionaryProperties.off),
      );
    }
    fieldHelper.changed = true;
  }

  /// internal method
  void _uncheckOthers(String value, bool check, PdfFieldHelper fieldHelper) {
    final PdfFieldItemCollection? items = (field as PdfCheckBoxField).items;
    if (items != null && items.count > 0) {
      final PdfFieldItemCollectionHelper fieldItemCollectionHelper =
          PdfFieldItemCollectionHelper.getHelper(items);
      if (fieldItemCollectionHelper.allowUncheck) {
        fieldItemCollectionHelper.allowUncheck = false;
        for (int i = 0; i < items.count; i++) {
          final PdfFieldItem item = items[i];
          if (item != fieldItem && item is PdfCheckBoxItem) {
            final String? val = fieldHelper.getItemValue(
              PdfFieldItemHelper.getHelper(item).dictionary!,
              fieldHelper.crossTable,
            );
            final bool v = val != null && val == value;
            if (v && check) {
              item.checked = true;
            } else {
              item.checked = false;
            }
          }
        }
      }
      fieldItemCollectionHelper.allowUncheck = true;
    }
  }
}

/// Represents loaded check box item.
class PdfCheckBoxItem extends PdfFieldItem {
  PdfCheckBoxItem._(super.field, super.index, super.dictionary) : super._();

  //Properties
  /// Gets or sets a value indicating whether the [PdfCheckBoxItem] is checked.
  bool get checked => _helper.obtainCheckedStatus();

  set checked(bool value) {
    if (!_helper.field.readOnly) {
      if (value != checked) {
        _helper.setCheckedStatus(value);
        PdfFormHelper.getHelper(_helper.field.form!).setAppearanceDictionary =
            true;
      }
    }
  }

  //Implementation
  void _setStyle(PdfCheckBoxStyle value) {
    String style = '';
    if (_helper.dictionary!.containsKey(PdfDictionaryProperties.mk)) {
      switch (value) {
        case PdfCheckBoxStyle.check:
          style = '4';
          break;
        case PdfCheckBoxStyle.circle:
          style = 'l';
          break;
        case PdfCheckBoxStyle.cross:
          style = '8';
          break;
        case PdfCheckBoxStyle.diamond:
          style = 'u';
          break;
        case PdfCheckBoxStyle.square:
          style = 'n';
          break;
        case PdfCheckBoxStyle.star:
          style = 'H';
          break;
      }
      final IPdfPrimitive? mk = _helper.dictionary![PdfDictionaryProperties.mk];
      if (mk is PdfReferenceHolder) {
        final IPdfPrimitive? widgetDict = mk.object;
        if (widgetDict is PdfDictionary) {
          if (widgetDict.containsKey(PdfDictionaryProperties.ca)) {
            widgetDict[PdfDictionaryProperties.ca] = PdfString(style);
          } else {
            widgetDict.setProperty(
              PdfDictionaryProperties.ca,
              PdfString(style),
            );
          }
        }
      } else if (mk is PdfDictionary) {
        mk[PdfDictionaryProperties.ca] = PdfString(style);
      }
    }
  }
}

// ignore: avoid_classes_with_only_static_members
/// [PdfCheckBoxItem] helper
class PdfCheckBoxItemHelper {
  /// internal method
  static void setStyle(PdfCheckBoxItem checkBoxItem, PdfCheckBoxStyle value) {
    checkBoxItem._setStyle(value);
  }

  /// internal method
  static PdfCheckBoxItem getItem(
    PdfField field,
    int index,
    PdfDictionary? dictionary,
  ) {
    return PdfCheckBoxItem._(field, index, dictionary);
  }
}

/// Represents an item in a text box field collection.
class PdfTextBoxItem extends PdfFieldItem {
  PdfTextBoxItem._(super.field, super.index, super.dictionary) : super._();
}

// ignore: avoid_classes_with_only_static_members
/// [PdfTextBoxItem] helper
class PdfTextBoxItemHelper {
  /// internal method
  static PdfTextBoxItem getItem(
    PdfField field,
    int index,
    PdfDictionary? dictionary,
  ) {
    return PdfTextBoxItem._(field, index, dictionary);
  }
}
