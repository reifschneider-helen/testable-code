CLASS ltc_roman_converter DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

  PRIVATE SECTION.
    DATA:
        go_cut TYPE REF TO z14_wtc_roman_converter.

    METHODS:
      assert_convert IMPORTING iv_roman  TYPE string
                               iv_arabic TYPE i,

      assert_error IMPORTING iv_error_value TYPE string,


      setup,

      verify_single      FOR TESTING RAISING cx_static_check,
      verify_additive    FOR TESTING RAISING cx_static_check,
      verify_subtractive FOR TESTING RAISING cx_static_check,
      verify_complex     FOR TESTING RAISING cx_static_check,

      error_cases        FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_roman_converter IMPLEMENTATION.

  METHOD setup.
    go_cut = NEW z14_wtc_roman_converter( ).

  ENDMETHOD.

  METHOD assert_convert.
    cl_abap_unit_assert=>assert_equals( act = go_cut->to_arabic( iv_roman )
                                        exp = iv_arabic ).

  ENDMETHOD.

  METHOD assert_error.
    cl_abap_unit_assert=>assert_equals( act = go_cut->to_arabic( iv_error_value )
                                        exp = z14_wtc_roman_converter=>error_value ).

  ENDMETHOD.

  METHOD verify_single.
    assert_convert( iv_roman = '' iv_arabic = 0 ).
    assert_convert( iv_roman = 'I' iv_arabic = 1 ).
    assert_convert( iv_roman = 'V' iv_arabic = 5 ).
    assert_convert( iv_roman = 'X' iv_arabic = 10 ).
    assert_convert( iv_roman = 'L' iv_arabic = 50 ).
    assert_convert( iv_roman = 'C' iv_arabic = 100 ).
    assert_convert( iv_roman = 'D' iv_arabic = 500 ).
    assert_convert( iv_roman = 'M' iv_arabic = 1000 ).
  ENDMETHOD.

  METHOD verify_additive.
    assert_convert( iv_roman = 'II' iv_arabic = 2 ).
    assert_convert( iv_roman = 'III' iv_arabic = 3 ).
    assert_convert( iv_roman = 'XV' iv_arabic = 15 ).
    assert_convert( iv_roman = 'XX' iv_arabic = 20 ).
    assert_convert( iv_roman = 'MM' iv_arabic = 2000 ).
  ENDMETHOD.

  METHOD verify_subtractive.
    assert_convert( iv_roman = 'IX' iv_arabic = 9 ).
    assert_convert( iv_roman = 'XC' iv_arabic = 90 ).
    assert_convert( iv_roman = 'CM' iv_arabic = 900 ).
  ENDMETHOD.

  METHOD verify_complex.
    assert_convert( iv_roman = 'XIV' iv_arabic = 14 ).
    assert_convert( iv_roman = 'CMXL' iv_arabic = 940 ).
    assert_convert( iv_roman = 'CMXLIII' iv_arabic = 943 ).
    assert_convert( iv_roman = 'MCMXLVII' iv_arabic = 1947 ).
  ENDMETHOD.

  METHOD error_cases.
    assert_error( iv_error_value = 'VV' ).
    assert_error( iv_error_value = 'AA' ).
    assert_error( iv_error_value = 'IIII' ).
    assert_error( iv_error_value = 'VX' ).
  ENDMETHOD.

ENDCLASS.
