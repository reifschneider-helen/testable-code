CLASS ltcl_shipping_processor DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

  PRIVATE SECTION.
    DATA:
      mo_cut             TYPE REF TO zcl_14_shipping_processor,
      mo_strategy_double TYPE REF TO zif_14_shipping_strategy.

    METHODS:
      setup,
      teardown,

      us_calculation_success FOR TESTING RAISING zcx_14_shipping_error,
      eu_calculation_success FOR TESTING RAISING zcx_14_shipping_error,
      invalid_country_error  FOR TESTING RAISING zcx_14_shipping_error.

ENDCLASS.



CLASS ltcl_shipping_processor IMPLEMENTATION.

  METHOD setup.
    mo_strategy_double = CAST zif_14_shipping_strategy(
                            cl_abap_testdouble=>create( 'zif_14_shipping_strategy' ) ).
    mo_cut = NEW #(  ).
  ENDMETHOD.

  METHOD teardown.
    zcl_14_shipping_calc_injector=>clear_test_doubles(  ).
  ENDMETHOD.

  METHOD us_calculation_success.
*   Configure return value on the existing double
    cl_abap_testdouble=>configure_call( mo_strategy_double )->returning(
                                    CONV zif_14_shipping_strategy=>ty_amount( '25.00' ) ).
    mo_strategy_double->calculate_fee( iv_weight_kg = 10 iv_declared_value = 100 ).

*   Inject double into Factory for 'US'
    zcl_14_shipping_calc_injector=>inject_test_double(
      iv_country = 'US'
      io_double  = mo_strategy_double ).

*   Execute & Assert
    DATA(lv_fee) = mo_cut->calculate_final_cost(
      iv_country        = 'US'
      iv_weight_kg      = 10
      iv_declared_value = 100 ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_fee
      exp = '25.00' ).
  ENDMETHOD.

  METHOD eu_calculation_success.
*  Configure return value on the existing double
    cl_abap_testdouble=>configure_call( mo_strategy_double )->returning(
                                    CONV zif_14_shipping_strategy=>ty_amount( '20.00' ) ).
    mo_strategy_double->calculate_fee( iv_weight_kg = 20 iv_declared_value = 200 ).

*   Inject double into Factory for 'US'
    zcl_14_shipping_calc_injector=>inject_test_double(
      iv_country = 'EU'
      io_double  = mo_strategy_double ).

*   Execute & Assert
    DATA(lv_fee) = mo_cut->calculate_final_cost(
      iv_country        = 'EU'
      iv_weight_kg      = 20
      iv_declared_value = 200 ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_fee
      exp = '20.00' ).

  ENDMETHOD.

  METHOD invalid_country_error.
    TRY.
        mo_cut->calculate_final_cost(
            iv_country = 'LL'
            iv_weight_kg = 30
            iv_declared_value = 300 ).

        cl_abap_unit_assert=>fail( msg = 'Expected exception for invalid country' ).

      CATCH zcx_14_shipping_error INTO DATA(lx_error).
        cl_abap_unit_assert=>assert_bound( act = lx_error ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

