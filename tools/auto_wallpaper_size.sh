#! /bin/bash

# TODO: 通过 exiftool 判断格式格式是否为图片，并且提供选项是直接覆盖还是重命名
# TODO: 判断图片尺寸和屏幕尺寸比，选择更合适的比例，让转化之后图片能占满屏幕，不会有空白

cmd=""
if command -v magick > /dev/null 2>&1; then
  cmd="magick"
elif command -v convert > /dev/null 2>&1; then
  cmd=convert
else
  echo "image magick not fond"
  exit 1
fi

width=1920
height=1080
rate=$(echo "scale=2; $width / $height" | bc)
if [ -f /sys/class/graphics/fb0/virtual_size ]; then
  width=$(cat /sys/class/graphics/fb0/virtual_size | awk -F ',' '{print $1}')
  height=$(cat /sys/class/graphics/fb0/virtual_size | awk -F ',' '{print $2}')
  rate=$(cat /sys/class/graphics/fb0/virtual_size | sed 's/,/ \/ /g' | sed 's/^/scale=2; /' | bc)
elif command -v xdpyinfo > /dev/null 2>&1; then
  width=$(xdpyinfo | grep dimensions | awk '{print $2}' | awk -F 'x' '{print $1}')
  height=$(xdpyinfo | grep dimensions | awk '{print $2}' | awk -F 'x' '{print $2}')
  rate=$(xdpyinfo | grep dimensions | awk '{print $2}' | sed 's/x/ \/ /g' | sed 's/^/scale=2; /' | bc)
elif command -v xrandr > /dev/null 2>&1; then
  width=$(xrandr | grep '*' | awk '{print $1}' | awk -F 'x' '{print $1}')
  height=$(xrandr | grep '*' | awk '{print $1}' | awk -F 'x' '{print $2}')
  rate=$(xrandr | grep '*' | awk '{print $1}' |  sed 's/x/ \/ /g' | sed 's/^/scale=2; /' | bc)
fi

echo "will convert to width: $width"
echo "-----------------------------"

for f in *; do
  sz="${width}x"
  prate=$(echo $(magick identify -format "scale=2; %w / %h" "$f") | bc)
  if (( $(echo "$prate > $rate" | bc -l) )); then
    # 让图片总能铺满屏幕，不会出现空白
    sz="x${height}"
  fi
  magick "$f" -resize "$sz" "$f"
  echo $f done
done
