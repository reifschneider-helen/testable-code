CLASS lcl_car DEFINITION.
  PUBLIC SECTION.
    TYPES:
      ty_fuel TYPE p LENGTH 5 DECIMALS 1.

    METHODS:
      constructor
        IMPORTING iv_name             TYPE string
                  iv_capacity         TYPE ty_fuel "capacity of gas tank in liters
                  iv_fuel_consumption TYPE ty_fuel, "liters per 100km the car consumes

      refuel "fill up the gas returning the number of liters used
        RETURNING VALUE(rv_liters_used) TYPE ty_fuel,

      drive_distance  "reduces the gas in the tank
        IMPORTING i_distance TYPE ty_fuel,

      get_current_tank_level "current tank level in percentage
        RETURNING VALUE(rv_curr_tank_level) TYPE ty_fuel.

  PRIVATE SECTION.
    DATA:
      lv_name             TYPE string,
      lv_capacity         TYPE ty_fuel,
      lv_curr_tank_level  TYPE ty_fuel,
      lv_fuel_consumption TYPE ty_fuel.

ENDCLASS.

CLASS lcl_car IMPLEMENTATION.

  METHOD constructor.
    lv_name = iv_name.
    lv_capacity = iv_capacity.
    lv_fuel_consumption = iv_fuel_consumption.

    lv_curr_tank_level = lv_capacity.

  ENDMETHOD.

  METHOD drive_distance.

    lv_curr_tank_level -= lv_fuel_consumption * ( i_distance / 100 ).

  ENDMETHOD.

  METHOD get_current_tank_level.

    rv_curr_tank_level = lv_curr_tank_level.

  ENDMETHOD.

  METHOD refuel.

    rv_liters_used = lv_capacity - lv_curr_tank_level.

    lv_curr_tank_level = lv_capacity.

  ENDMETHOD.

ENDCLASS.
