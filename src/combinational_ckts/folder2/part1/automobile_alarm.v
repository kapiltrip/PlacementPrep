// Simple automobile alarm logic with active-low output
module automobile_alarm (
    input  wire door_open,
    input  wire ignition_on,
    input  wire headlight_on,
    output wire alarm_n
);
    wire hazard_light = headlight_on & ~ignition_on;
    wire hazard_door  = door_open    &  ignition_on;
    assign alarm_n = ~ (hazard_light | hazard_door);
endmodule
