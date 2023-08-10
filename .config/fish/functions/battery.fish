function battery
  pmset -g batt | grep -Eo "\d+%"
end
