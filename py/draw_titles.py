#!/usr/local/bin/python3
import sys
import os
import argparse
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

argsparser = argparse.ArgumentParser()
argsparser.add_argument("--delim", "-d", type=str,
                        default='/', help="field delimeter character in file")
argsparser.add_argument("--size", "-s", type=int,
                        default=180, help="font size to draw in points")
argsparser.add_argument("--paint", "-p", type=str,
                        default="ff0000", help="color of titles to paint")
argsparser.add_argument("--name", "-n", type=str,
                        default=argparse.SUPPRESS, help="specific file name to title")
argsparser.add_argument("--cat", "-c", type=str,
                        default=argparse.SUPPRESS, help="catalog to save titled files")
argsparser.add_argument(
    "file", type=str, help="path to file containing files' names and titles")
args = argsparser.parse_args()

paint = tuple(int(args.paint[i:i+2], 16) for i in range(0, 6, 2))

with open(args.file, 'r') as f:
    for line in f:
        try:
            file, title = map(str.strip, line.split(args.delim))
        except ValueError:
            print(f"{file} hasn't got value")
            continue

        if hasattr(args, 'name') and not file.startswith(args.name):
            continue

        try:
            img = Image.open(file)
        except IOError:
            print(f"{file} couldn't find file")
            continue

        iw, ih = img.size
        draw = ImageDraw.Draw(img)
        font = ImageFont.truetype("DejaVuSans.ttf", int(args.size))
        fw, fh = font.getsize(title)
        draw.text((iw - 1.15*fw, ih - 1.2*fh), title, paint, font=font)

        if hasattr(args, 'cat'):
            if not os.path.exists(args.cat):
                os.makedirs(args.cat)

            img.save(args.cat + '/' + file)
        else:
            img.save(file)
