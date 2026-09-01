CLASS zcl_14_shipping_eu DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: zif_14_shipping_strategy.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
        ty_percent TYPE p LENGTH 2 DECIMALS 2.

    CONSTANTS:
      lc_flat_rate       TYPE zif_14_shipping_strategy=>ty_amount VALUE 15,
      lc_rate_per_amount TYPE ty_percent VALUE '0.05'.
ENDCLASS.

CLASS zcl_14_shipping_eu IMPLEMENTATION.
  METHOD zif_14_shipping_strategy~calculate_fee.
    rv_fee = lc_flat_rate + lc_rate_per_amount * iv_declared_value.
  ENDMETHOD.

ENDCLASS.
