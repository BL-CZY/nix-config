if [ $(eww get show_calendar) == "false" ]; then
    eww update cal="calendar_pre"
    eww open calendar;
    eww update cal="calendar"
    eww update show_calendar="true";
else
    eww close calendar;
    eww update show_calendar="false";
fi