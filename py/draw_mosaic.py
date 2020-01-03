#!/usr/bin/env python3
import sys
import os
import glob
import argparse
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

ap = argparse.ArgumentParser(description='Draw mosaic from captioned images.')
ap.add_argument('-s', '--size', type=int, help='font size in pixels')
ap.add_argument('-c', '--color', type=str, help='font color RGB code in hex')
ap.add_argument('-d', '--dir', type=str, help='path to directory containing source images')
ap.add_argument('-l', '--layout', type=str, help='dimensions for each mosaic')
ap.add_argument('-r', '--resize', type=int, help='resize images height before stacking')
ap.add_argument('-b', '--border', type=str, help='color for borders around text')
args = ap.parse_args()

font_size = args.size * 0.75 # point to pixel ratio
font_color = tuple(int(args.color[i:i+2], 16) for i in range(0, 6, 2))
images_dir = args.dir.rstrip('/')
col, row = map(int, args.layout.split('x'))
resize_height = args.resize
border = args.border and tuple(int(args.border[i:i+2], 16) for i in range(0, 6, 2))

images = {}
row_number = 1
for line in sys.stdin:

    name, top, left, size, text = map(str.strip, line.split(':'))

    if not name:
        print(f'empty name for row #{row_number}')
        continue

    if not text:
        print(f'empty text value for row #{row_number}')
        continue

    top = not top and 0.5 or float(top) / 100
    left = not left and 0.5 or float(left) / 100
    size = int(size and int(size) * 0.75 or font_size)

    file, path = '', ''
    for extension in ['jpg', 'jpeg', 'png']:
        if os.path.exists(images_dir + '/' + name + '.' + extension):
            file = name + '.' + extension
            break

    if not file:
        print(f'file for "{name}" does not exist')
        continue

    if file not in images:
        images[file] = [[top, left, size, text]]
    else:
        images[file].append([top, left, size, text])

    row_number += 1

for file in images:

    path = images_dir + '/' + file;
    try:
        image = Image.open(path)
    except IOError:
        print(f'could not open file "{path}" for captioning')
        continue

    draw = ImageDraw.Draw(image)
    image_width, image_height = image.size

    for draw_text in images[file]:
        top, left, size, text = draw_text

        font = ImageFont.truetype('DejaVuSans.ttf', size)
        font_width, font_height = font.getsize(text)
        x, y = image_width * left - font_width / 2, image_height * top - font_height / 2

        if border:
            for offset in ([-1, +1], [+1, +1], [-1, -1], [+1, -1]):
                draw.text((x + offset[0], y + offset[1]), text, border, font=font)

        draw.text((x, y), text, font_color, font=font)

    image.save(file)

mosaic = Image.new(mode='RGB', size=(15000, 15000))
x, y, count, mosaic_count = 0, 0, 0, 1
for file in images:

    image = Image.open(file)
    image_width, image_height = image.size
    if resize_height and resize_height != image_height:
        image_width = int(image_width * resize_height / image_height), resize_height
        image = image.resize((image_width, resize_height))

    mosaic.paste(image, (x, y))
    count += 1

    x += image_width

    if count == col * row:
        mosaic = mosaic.crop(box=(0, 0, x, y + image_height))
        mosaic.save(f'mosaic{mosaic_count}.jpg')
        mosaic = Image.new(mode='RGB', size=(15000, 15000))
        mosaic_count += 1
        x, y, count = 0, 0, 0
    elif count % col == 0:
        x, y = 0, y + image_height
