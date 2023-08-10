function weather
  curl -s v2d.wttr.in | ghead -n -2
end
