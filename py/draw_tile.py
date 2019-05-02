#!/usr/local/bin/python3
import sys
import glob
import argparse
from PIL import Image

argsparser = argparse.ArgumentParser()
argsparser.add_argument("--size", "-s", type=str,
                        default="6x3", help="maximum size for each tile")
argsparser.add_argument("--paint", "-p", type=str,
                        default="524e4e", help="color for background")
argsparser.add_argument("--cat", "-c", type=str,
                        default=".", help="catalog to read images from")
args = argsparser.parse_args()

cols, rows = map(int, args.size.split('x'))
paint = tuple(int(args.paint[i:i+2], 16) for i in range(0, 6, 2))

# Load all images
images = []
for f in glob.glob(f'{args.cat}/*'):
    try:
        img = Image.open(f)
    except IOError:
        print(f"couldn't open file {f}")
        continue
    images.append(img)

# Sort ascending by squares to minimize 'whitespace'
images.sort(key=lambda img: img.width*img.height, reverse=True)

# Make tiles from images
imglen = len(images)
tiles = [
    [[images[x] for x in range(y, min(y + cols, imglen))]    # for each col
        for y in range(t, min(t + rows*cols, imglen), cols)] # for each row
    for t in range(0, imglen, rows*cols)                     # for each tile
]

# Draw by stacking images on tiles
tiles_count = 0
for tile in tiles:
    tile_image = Image.new(mode='RGB', size=(15000, 15000), color=paint)
    tile_width, tile_height = 0, 0

    y = 0
    for row in tile:
        x = 0
        max_height = 0

        for img in row:
            tile_image.paste(img, (x, y))
            x += img.width
            if img.height > max_height:
                max_height = img.height

        y += max_height

        tile_height = y
        if x > tile_width:
            tile_width = x

    tiles_count += 1
    tile_image = tile_image.crop(box=(0, 0, tile_width, tile_height))
    tile_image.save(f'tile{tiles_count}.jpg')
