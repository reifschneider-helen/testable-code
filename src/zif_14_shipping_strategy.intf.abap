INTERFACE zif_14_shipping_strategy
  PUBLIC .
  TYPES:
    ty_weight_kg TYPE p LENGTH 8 DECIMALS 2,
    ty_amount    TYPE p LENGTH 8 DECIMALS 2.

  METHODS:
    calculate_fee IMPORTING iv_weight_kg      TYPE ty_weight_kg
                            iv_declared_value TYPE ty_amount
                  RETURNING VALUE(rv_fee)     TYPE ty_amount
                  RAISING   zcx_14_shipping_error.
ENDINTERFACE.
