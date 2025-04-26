function moonshot
  curl -s wttr.in/Moon | tail -r | sed -e '1,3d' | tail -r
end
