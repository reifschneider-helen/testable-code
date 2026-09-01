CLASS zcl_14_shipping_us DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: zif_14_shipping_strategy.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      lc_flat_rate   TYPE zif_14_shipping_strategy=>ty_amount VALUE 10,
      lc_rate_per_kg TYPE zif_14_shipping_strategy=>ty_amount VALUE 2.

ENDCLASS.

CLASS zcl_14_shipping_us IMPLEMENTATION.
  METHOD zif_14_shipping_strategy~calculate_fee.
    rv_fee = lc_flat_rate + lc_rate_per_kg * iv_weight_kg.
  ENDMETHOD.

ENDCLASS.
