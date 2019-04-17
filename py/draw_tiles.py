#!/usr/local/bin/python3
import sys
import glob
from PIL import Image

catalog = '.'
if len(sys.argv) > 1:
    catalog = sys.argv[1]

cols, rows = 6, 3
if len(sys.argv) > 2:
    cols, rows = [int(d) for d in sys.argv[2].split('x')]

bgcolor = '524e4e'
if len(sys.argv) > 3:
    bgcolor = sys.argv[3]
bgcolor = tuple(int(bgcolor[i:i+2], 16) for i in range(0, 6, 2))

# Load all images
images = []
for f in glob.glob(f'{catalog}/*'):
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
tiles =
[
    [[images[x] for x in range(y, min(y + cols, imglen))]    # for each col
        for y in range(t, min(t + rows*cols, imglen), cols)] # for each row
            for t in range(0, imglen, rows*cols)             # for each tile
]

# Draw by stacking images on tiles
tiles_count = 0
for tile in tiles:
    tile_image = Image.new(mode='RGB', size=(15000, 15000), color=bgcolor)
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
