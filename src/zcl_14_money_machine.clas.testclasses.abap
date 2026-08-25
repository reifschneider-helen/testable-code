CLASS ltc_money_machine DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

  PRIVATE SECTION.
    DATA:
        lo_cut TYPE REF TO zcl_14_money_machine.

    METHODS:
      setup,
      should_return_only_coins IMPORTING iv_amount TYPE i
                                         iv_change TYPE zcl_14_money_machine=>tt_change,
      valid_cases  FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS  ltc_money_machine IMPLEMENTATION.
  METHOD setup.
    lo_cut = NEW #(  ).
  ENDMETHOD.

  METHOD should_return_only_coins.
    cl_abap_unit_assert=>assert_equals( act = lo_cut->get_change( iv_amount )
                                        exp = iv_change ).


  ENDMETHOD.

  METHOD valid_cases.
    should_return_only_coins( iv_amount = 1
                              iv_change = VALUE zcl_14_money_machine=>tt_change(
                                        ( amount = 2 type = 'coin'   ) ) ).
  ENDMETHOD.

ENDCLASS.
