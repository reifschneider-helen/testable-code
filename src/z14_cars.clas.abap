CLASS z14_cars DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z14_cars IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA:
      lo_porsche TYPE REF TO lcl_car,
      lo_bmw     TYPE REF TO lcl_car,
      lo_vw      TYPE REF TO lcl_car.

    CREATE OBJECT lo_porsche
      EXPORTING
        iv_name             = '911'
        iv_capacity         = 40
        iv_fuel_consumption = 5.

    lo_porsche->drive_distance( 100 ).

    out->write( 'Current tank level:' ).
    out->write( lo_porsche->get_current_tank_level( ) ).

    out->write( '' ).
    out->write( 'Amount of gas was tanked:' ).
    out->write( lo_porsche->refuel( ) ).

    out->write( '' ).
    out->write( 'Current tank level:' ).
    out->write( lo_porsche->get_current_tank_level( ) ).

  ENDMETHOD.
ENDCLASS.
