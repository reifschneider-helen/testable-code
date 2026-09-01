CLASS zcx_14_exceptions DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .


    CONSTANTS:
      BEGIN OF invalid_value,
        msgid TYPE symsgid VALUE 'ZMSG_14_COMMON',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'GV_MSGV1',
        attr2 TYPE scx_attrname VALUE 'GV_MSGV2',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_value.

    " Public Attributes (READ-ONLY) to hold message place-holders &1-&4
    DATA gv_msgv1 TYPE string READ-ONLY.
    DATA gv_msgv2 TYPE string READ-ONLY.
    DATA gv_msgv3 TYPE string READ-ONLY.
    DATA gv_msgv4 TYPE string READ-ONLY.

    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL
        iv_msgv1 TYPE simple OPTIONAL
        iv_msgv2 TYPE simple OPTIONAL
        iv_msgv3 TYPE simple OPTIONAL
        iv_msgv4 TYPE simple OPTIONAL.

ENDCLASS.



CLASS zcx_14_exceptions IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    me->gv_msgv1 = |{ iv_msgv1 }|.
    me->gv_msgv2 = |{ iv_msgv2 }|.
    me->gv_msgv3 = |{ iv_msgv3 }|.
    me->gv_msgv4 = |{ iv_msgv4 }|.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
