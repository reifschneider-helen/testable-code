CLASS zcl_14_shipping_calc_injector DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  FOR TESTING .

  PUBLIC SECTION.
  CLASS-METHODS:
    inject_test_double IMPORTING iv_country TYPE z14_shipping_con-country_code
                                 io_double TYPE REF TO zif_14_shipping_strategy,
    clear_test_doubles.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_14_shipping_calc_injector IMPLEMENTATION.
  METHOD inject_test_double.
*  Access to the gt_test_doubles via FRIENDS relationship
    APPEND VALUE #( country_code = iv_country
                    strategy_class = io_double ) TO zcl_14_shipping_calc_factory=>gt_test_doubles.
  ENDMETHOD.

  METHOD clear_test_doubles.
    CLEAR zcl_14_shipping_calc_factory=>gt_test_doubles.
  ENDMETHOD.

ENDCLASS.
