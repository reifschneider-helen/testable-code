CLASS ltc_money_machine DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

  PRIVATE SECTION.
    DATA:
        lo_cut TYPE REF TO zcl_14_money_machine.

    METHODS:
      setup,
      assert_change IMPORTING iv_amount   TYPE i
                              it_expected TYPE zcl_14_money_machine=>tt_change
                    RAISING   zcx_14_exceptions,

      assert_error  IMPORTING iv_amount TYPE i,

      "Valid values
      returns_single_coins          FOR TESTING RAISING cx_static_check,
      returns_multiple_coins        FOR TESTING RAISING cx_static_check,
      returns_mixed_coins_and_notes FOR TESTING RAISING cx_static_check,
      returns_single_notes          FOR TESTING RAISING cx_static_check,
      returns_multiple_notes        FOR TESTING RAISING cx_static_check,

      "Invalid values
      raises_exception              FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS  ltc_money_machine IMPLEMENTATION.
  METHOD setup.
    lo_cut = NEW #(  ).
  ENDMETHOD.

  METHOD assert_change.
    cl_abap_unit_assert=>assert_equals( act = lo_cut->get_change( iv_amount )
                                        exp = it_expected   ).

  ENDMETHOD.

  METHOD assert_error.
    TRY.
        lo_cut->get_change( iv_amount ).
        cl_abap_unit_assert=>fail( ). "no exception was raised

      CATCH zcx_14_exceptions.
    ENDTRY.
  ENDMETHOD.

  METHOD returns_single_coins.
    assert_change( iv_amount = 1
                   it_expected = VALUE #( ( amount = 1 type = 'coin' ) ) ).

    assert_change( iv_amount = 2
                   it_expected = VALUE #( ( amount = 2 type = 'coin' ) ) ).

  ENDMETHOD.

  METHOD returns_multiple_coins.
    assert_change( iv_amount = 3
                   it_expected = VALUE #( ( amount = 2 type = 'coin' )
                                          ( amount = 1 type = 'coin' ) ) ).

    assert_change( iv_amount = 4
                   it_expected = VALUE #( ( amount = 2 type = 'coin' )
                                          ( amount = 2 type = 'coin' ) ) ).
  ENDMETHOD.

  METHOD returns_mixed_coins_and_notes.
    assert_change( iv_amount = 6
                    it_expected = VALUE #( ( amount = 5 type = 'note' )
                                           ( amount = 1 type = 'coin' ) ) ).
    assert_change( iv_amount = 9
                      it_expected = VALUE #( ( amount = 5 type = 'note' )
                                             ( amount = 2 type = 'coin' )
                                             ( amount = 2 type = 'coin' ) ) ).
  ENDMETHOD.

  METHOD returns_single_notes.
    assert_change( iv_amount = 5
                      it_expected = VALUE #( ( amount = 5 type = 'note' ) ) ).
    assert_change( iv_amount = 200
                      it_expected = VALUE #( ( amount = 200 type = 'note' ) ) ).
  ENDMETHOD.

  METHOD returns_multiple_notes.
    assert_change( iv_amount = 30
                    it_expected = VALUE #( ( amount = 20 type = 'note' )
                                           ( amount = 10 type = 'note' ) ) ).
    assert_change( iv_amount = 300
                      it_expected = VALUE #( ( amount = 200 type = 'note' )
                                             ( amount = 100 type = 'note' ) ) ).
  ENDMETHOD.

  METHOD  raises_exception.
    assert_error( 0 ).
    assert_error( -1 ).

  ENDMETHOD.

ENDCLASS.
