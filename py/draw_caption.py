#!/usr/bin/env python3
import sys
import os
import argparse
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

ap = argparse.ArgumentParser(description='Draw caption to image.')
ap.add_argument('-d', '--delim', type=str, default='/', help='fields separation delimeter for SOURCE')
ap.add_argument('-s', '--font_size', type=int, default=180, help='in pixels')
ap.add_argument('-c', '--font_color', type=str, default='ff0000', help='RGB code in hex')
ap.add_argument('-f', '--path_from', type=str, default='./', help='path to image files')
ap.add_argument('-t', '--path_to', type=str, default='./', help='path where to save results')
ap.add_argument('source', metavar='SOURCE', type=str, help='path to file containing image name and caption to draw')
args = ap.parse_args()

font_color = tuple(int(args.font_color[i:i+2], 16) for i in range(0, 6, 2))
path_from = args.path_from.rstrip('/')
path_to = args.path_to.rstrip('/')
font_size = args.font_size * 0.75 # point to pixel ratio

if not os.path.exists(path_to):
    os.makedirs(path_to)

with open(args.source, 'r') as src:

    for line in src:
        try:
            file, title = map(str.strip, line.split(args.delim))
        except ValueError:
            print(f"{file} hasn't got value")
            continue

        try:
            img = Image.open(path_from + '/' + file)
        except IOError:
            print(f"{file} couldn't find file")
            continue

        iw, ih = img.size
        draw = ImageDraw.Draw(img)
        font = ImageFont.truetype('DejaVuSans.ttf', int(font_size))
        fw, fh = font.getsize(title)
        draw.text((iw - 1.15*fw, ih - 1.2*fh), title, font_color, font=font)
        img.save(path_to + '/' + file)
