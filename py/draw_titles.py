#!/usr/local/bin/python3
import sys
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw 

if len(sys.argv) < 2:
    print("error, should've specified file")
    sys.exit(1)

with open(sys.argv[1],'r') as f:
    for line in f:
        try:
            file, title = line.split('/')
            file = file.strip()
            title = title.strip()
        except ValueError:
            print(f"{file} hasn't have value")
            continue

        if len(sys.argv) == 3 and not file.startswith(sys.argv[2]):
            continue


        try:
            img = Image.open(file)
        except IOError:
            print(f"{file} couldn't find file")
            continue

        iw, ih = img.size
        draw = ImageDraw.Draw(img)
        font = ImageFont.truetype("DejaVuSans.ttf", int(ih / 15))
        fw, fh = font.getsize(title)
        draw.text((iw - 1.15*fw, ih - 1.2*fh), title, (255,0,0), font=font)
        img.save(file)
