from pathlib import Path
from PyTexturePacker import Packer
from PIL import Image
from scipy.spatial import ConvexHull
from deppth.entries import AtlasEntry
import json
import os

# To use this script, you'll need to pip install scipy and PyTexturePacker in addition to deppth and pillow
SOURCE_DIRECTORY = 'img' # The directory to recursively search for images in
BASENAME = 'Keepsakes' # Filenames created will start with this plus a number
INCLUDE_HULLS = False # Change to True if you want hull points computed and added
PACKAGE_NAME = "zannc-KeepsakePort" # Change to whatever Package name you want

MANIFEST_DIR = 'build/manifest'
TEXTURES_DIR = 'build/textures/atlases'

def build_atlases(source_dir, basename, include_hulls=False):
    files = find_files(source_dir)
    hulls = {file.name: get_hull_points(file) if include_hulls else [] for file in files}
    namemap = {file.name: str(file) for file in files}

    Path(MANIFEST_DIR).mkdir(parents=True, exist_ok=True)
    Path(TEXTURES_DIR).mkdir(parents=True, exist_ok=True)

    # Perform the packing
    packer = Packer.create( max_width=2880, max_height=2880, bg_color=0x00000000, atlas_format='json',
        enable_rotated=False, trim_mode=1, border_padding=0, shape_padding=0)
    packer.pack(files, f'{basename}%d')

    # Transform the atlases
    atlases = []
    index = 0
    while os.path.exists(f'{basename}{index}.json'):
        atlases.append(transform_atlas(f'{basename}{index}.json', namemap, hulls, source_dir))
        os.remove(f'{basename}{index}.json')
        index += 1

    for file in Path('.').glob(f'{basename}*.png'):
        destpng = os.path.join(TEXTURES_DIR, file.name)
        os.rename(file, destpng)

    for file in Path('.').glob(f'{basename}*.atlas.json'):
        destatlas = os.path.join(MANIFEST_DIR, file.name)
        os.rename(file, destatlas)

    os.system(f'deppth pk -s build -t {PACKAGE_NAME}.pkg')

def find_files(source_dir):
    return list(Path(source_dir).rglob('*.png'))

def get_hull_points(path):
    im = Image.open(path)
    points = [(x, y) for x in range(im.width) for y in range(im.height) if im.getpixel((x, y))[3] > 4]

    if points:
        try:
            hull = ConvexHull(points)
            return [(points[vertex][0], points[vertex][1]) for vertex in hull.vertices]
        except:
            return []
    return []

def transform_atlas(filename, namemap, hulls, source_dir):
    with open(filename) as f:
        ptp_atlas = json.load(f)

    frames = ptp_atlas['frames']
    atlas = AtlasEntry()
    atlas.version = 4
    atlas.name = f'bin\\Win\\Atlases\\{os.path.splitext(filename)[0]}'
    atlas.referencedTextureName = atlas.name
    atlas.isReference = True
    atlas.subAtlases = []

    for texture_name, frame in frames.items():
        subatlas = {
            'name': os.path.relpath(namemap[texture_name], source_dir).split(".png")[0],
            'topLeft': {'x': frame['spriteSourceSize']['x'], 'y': frame['spriteSourceSize']['y']},
            'originalSize': {'x': frame['sourceSize']['w'], 'y': frame['sourceSize']['h']},
            'rect': {
                'x': frame['frame']['x'],
                'y': frame['frame']['y'],
                'width': frame['frame']['w'],
                'height': frame['frame']['h']
            },
            'scaleRatio': {'x': 1.0, 'y': 1.0},
            'isMulti': False,
            'isMip': False,
            'isAlpha8': False,
            'hull': transform_hull(hulls[texture_name], {'x': frame['spriteSourceSize']['x'], 'y': frame['spriteSourceSize']['y']}, (frame['frame']['w'], frame['frame']['h']))
        }
        atlas.subAtlases.append(subatlas)

    atlas.export_file(f'{os.path.splitext(filename)[0]}.atlas.json')
    return atlas

def transform_hull(hull, topLeft, size):
    def transform_point(point):
        x = point[0] - topLeft['x'] - round(size[0] / 2.0)
        y = point[1] - topLeft['y'] - round(size[1] / 2.0)
        return [x, y]

    return [transform_point(point) for point in hull]

build_atlases(SOURCE_DIRECTORY, BASENAME, INCLUDE_HULLS)
