CLASS zcl_14_money_machine DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_change,
        amount TYPE i,
        type   TYPE string,
      END OF ty_change,

      tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.

    METHODS:
      constructor,

      get_change
        IMPORTING iv_amount        TYPE i
        RETURNING VALUE(rt_change) TYPE tt_change
        RAISING zcx_14_exceptions.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      lt_ordered_amounts TYPE tt_change.

ENDCLASS.



CLASS zcl_14_money_machine IMPLEMENTATION.
  METHOD constructor.
    lt_ordered_amounts = VALUE #(
        ( amount = 500 type = 'note' )
        ( amount = 200 type = 'note' )
        ( amount = 100 type = 'note' )
        ( amount = 50  type = 'note' )
        ( amount = 20  type = 'note' )
        ( amount = 10  type = 'note' )
        ( amount = 5   type = 'note' )
        ( amount = 2   type = 'coin' )
        ( amount = 1   type = 'coin' )  ).
  ENDMETHOD.

  METHOD get_change.
    IF iv_amount <= 0.
        RAISE EXCEPTION NEW zcx_14_exceptions( textid = zcx_14_exceptions=>invalid_value
                                               iv_msgv1 = iv_amount
                                               iv_msgv2 = 'money machine' ).
        EXIT.
    ENDIF.

    DATA(lv_remaining_amount) = iv_amount.


    LOOP AT lt_ordered_amounts ASSIGNING FIELD-SYMBOL(<ls_amount>).

     WHILE lv_remaining_amount >= <ls_amount>-amount.
            APPEND <ls_amount> TO rt_change.
            lv_remaining_amount -= <ls_amount>-amount.
      ENDWHILE.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
