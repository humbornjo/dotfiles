function weather
  curl -s v2d.wttr.in | tail -r | sed -e '1,3d' | tail -r
end
