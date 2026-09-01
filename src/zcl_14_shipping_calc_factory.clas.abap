CLASS zcl_14_shipping_calc_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
   CLASS-METHODS:
      get_strategy IMPORTING iv_country         TYPE z14_shipping_con-country_code
                   RETURNING VALUE(ro_strategy) TYPE REF TO zif_14_shipping_strategy
                   RAISING zcx_14_shipping_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
        BEGIN OF ty_test_double,
            country_code TYPE z14_shipping_con-country_code,
            strategy_class TYPE REF TO zif_14_shipping_strategy,
        END OF ty_test_double.

    CLASS-DATA:
        gt_test_doubles TYPE STANDARD TABLE OF ty_test_double WITH KEY country_code.

ENDCLASS.



CLASS zcl_14_shipping_calc_factory IMPLEMENTATION.
  METHOD get_strategy.
    READ TABLE gt_test_doubles ASSIGNING FIELD-SYMBOL(<ls_test_double>)
    WITH TABLE KEY country_code = iv_country.

    IF sy-subrc = 0.
    ro_strategy = <ls_test_double>-strategy_class.
    RETURN.
    ENDIF.


    SELECT SINGLE strategy_class
    FROM z14_shipping_con
    WHERE country_code = @iv_country
    INTO @DATA(lv_class).

    IF sy-subrc <> 0 OR lv_class IS INITIAL.
        RAISE EXCEPTION NEW zcx_14_shipping_error(
                    textid = zcx_14_shipping_error=>country_not_found
                    iv_var1 = |{ iv_country }| ).
    ENDIF.

    TRY.
    CREATE OBJECT ro_strategy TYPE (lv_class).

    CATCH cx_dynamic_check INTO DATA(lx_sys_error).
        RAISE EXCEPTION NEW zcx_14_shipping_error(
                    textid = zcx_14_shipping_error=>invalid_strategy_class
                    iv_var1 = |{ lv_class }|
                    previous = lx_sys_error
                    ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
