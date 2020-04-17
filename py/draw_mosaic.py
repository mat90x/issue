#!/usr/bin/env python3
import sys
import os
import argparse
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

ap = argparse.ArgumentParser(description='Draw mosaic from captioned images.')
ap.add_argument('dir', type=str, metavar='DIR', help='path to directory containing images')
ap.add_argument('dimension', type=str, metavar='DIMENSION', help='dimensions for each mosaic')
ap.add_argument('font_size', type=int, metavar='FONT_SIZE', help='font size in pixels')
ap.add_argument('-f', '--font_color', type=str, default='ff0000', help='font color RGB code in hex')
ap.add_argument('-w', '--stroke_width', type=int, help='width for strokes around text')
ap.add_argument('-s', '--stroke_color', type=str, default='ffffff', help='color for strokes around text')
ap.add_argument('-t', '--margin_top', type=int, default=50, help='margin from top to the center of text')
ap.add_argument('-l', '--margin_left', type=int, default=50, help='margin from left to the center of text')
ap.add_argument('-r', '--resize', type=int, help='resize images height before stacking')
ap.add_argument('-i', '--save_images', action='store_true', help='save intermediate images')
args = ap.parse_args()

args.dir = args.dir.rstrip('/')
cols, rows = map(int, args.dimension.split('x'))
args.font_size = int(args.font_size * 0.75) # point to pixel ratio
font_color = tuple(int(args.font_color[i:i+2], 16) for i in range(0, 6, 2))
stroke_color = tuple(int(args.stroke_color[i:i+2], 16) for i in range(0, 6, 2))

images = {}
row_number = 1
for line in sys.stdin:

    try:
        name, margin_top, margin_left, size, text = map(str.strip, line.split(':'))
    except ValueError:
        print(f'wrong format for row #{row_number}')
        sys.exit(1)

    if not name:
        print(f'empty name for row #{row_number}')
        sys.exit(1)
    elif name.startswith('#'):
        continue

    margin_top, margin_left = args.margin_top / 100, args.margin_left / 100
    size = int(size and int(size) * 0.75 or args.font_size)

    file, path = '', ''
    for extension in ['jpg', 'jpeg', 'png']:
        if os.path.exists(args.dir + '/' + name + '.' + extension):
            file = name + '.' + extension
            break

    if not file:
        print(f'file for "{name}" does not exist')
        sys.exit(1)

    if file not in images:
        images[file] = [[margin_top, margin_left, size, text]]
    else:
        images[file].append([margin_top, margin_left, size, text])

    row_number += 1

mosaic = Image.new(mode='RGB', size=(15000, 15000))
mosaic_count = 1
paste_count = 0
crop_x, crop_y = 0, 0
paste_x, paste_y = 0, 0
row_height = 0
for file in images:

    path = args.dir + '/' + file;
    try:
        image = Image.open(path)
    except IOError:
        print(f'could not open file "{path}" for captioning')
        sys.exit(1)

    draw = ImageDraw.Draw(image)
    image_width, image_height = image.size

    for draw_text in images[file]:
        margin_top, margin_left, size, text = draw_text

        font = ImageFont.truetype('DejaVuSans.ttf', size)
        font_width, font_height = font.getsize(text)
        x = image_width * margin_left - font_width / 2
        y = image_height * margin_top - font_height / 2

        if args.stroke_width:
            draw.text((x, y), text, font_color, font, stroke_fill=stroke_color, stroke_width=args.stroke_width)
        else:
            draw.text((x, y), text, font_color, font, stroke_fill=stroke_color, stroke_width=args.stroke_width)

    if args.resize and args.resize != image_height:
        image_width = int(image_width * args.resize / image_height)
        image_height = args.resize
        image = image.resize((image_width, image_height))

    if args.save_images:
        image.save(file)

    mosaic.paste(image, (paste_x, paste_y))
    paste_count += 1

    paste_x += image_width
    crop_x = max(crop_x, paste_x)
    row_height = max(row_height, image_height)

    if paste_count % cols == 0:
        crop_y += row_height
        row_height = 0

        if paste_count == cols * rows:
            mosaic = mosaic.crop(box=(0, 0, crop_x, crop_y))
            mosaic.save(f'mosaic{mosaic_count}.jpg')
            mosaic_count += 1

            mosaic = Image.new(mode='RGB', size=(15000, 15000))
            paste_x, paste_y = 0, 0
            crop_x, crop_y = 0, 0
            paste_count = 0

        else:
            paste_x, paste_y = 0, crop_y

if paste_count:
    mosaic = mosaic.crop(box=(0, 0, crop_x, crop_y + row_height))
    mosaic.save(f'mosaic{mosaic_count}.jpg')
