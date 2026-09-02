CLASS zcl_14_shipping_processor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      calculate_final_cost IMPORTING iv_country    TYPE z14_shipping_con-country_code
                                     iv_weight_kg     TYPE zif_14_shipping_strategy=>ty_weight_kg
                                     iv_declared_value     TYPE zif_14_shipping_strategy=>ty_amount
                           RETURNING VALUE(rv_fee) TYPE zif_14_shipping_strategy=>ty_amount
                           RAISING   zcx_14_shipping_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_14_shipping_processor IMPLEMENTATION.
  METHOD calculate_final_cost.
    DATA(lo_strategy) = zcl_14_shipping_calc_factory=>get_strategy( iv_country ).
    rv_fee = lo_strategy->calculate_fee( iv_weight_kg = iv_weight_kg
                                         iv_declared_value = iv_declared_value ).
  ENDMETHOD.

ENDCLASS.
