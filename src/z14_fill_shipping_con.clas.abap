CLASS z14_fill_shipping_con DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z14_fill_shipping_con IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    INSERT  z14_shipping_con FROM TABLE @(
    VALUE #( ( country_code = 'US' strategy_class = 'ZCL_14_SHIPPING_US' )
             ( country_code = 'DE' strategy_class = 'ZCL_14_SHIPPING_EU' ) ) ).

    IF sy-subrc = 0.
      out->write( 'Table was filled successfully' ).
    ELSE.
      out->write( 'An error occured while filling table' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
