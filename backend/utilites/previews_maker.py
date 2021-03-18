import os
import shutil
from PIL import Image
import numpy as np

BACKGROUNDS_DIR = "./backgrounds/"
MAX_SIZE = (200, 200)

# вырезание центра
def crop_center(pil_img, crop_width, crop_height):
    img_width, img_height = pil_img.size
    return pil_img.crop(((img_width - crop_width) // 2,
                         (img_height - crop_height) // 2,
                         (img_width + crop_width) // 2,
                         (img_height + crop_height) // 2))

# вырезание центра по максимальному краю
def crop_max_square(pil_img):
    return crop_center(pil_img, min(pil_img.size), min(pil_img.size))

# прочитать все файлы в каталоге csv
all_back_dirs = os.listdir(BACKGROUNDS_DIR)

# итерируемся по папкам
for pics_dir in all_back_dirs:
    current_backs_dir = BACKGROUNDS_DIR + pics_dir + "/"
    current_previews_dir = current_backs_dir + "previews/"

    # пересоздание превью каталогов
    print(current_previews_dir)
    try:
        shutil.rmtree(current_previews_dir)
    except:
        print(f'Каталог {current_previews_dir} пересоздан')
    os.makedirs(current_previews_dir)
    
    # создание превьюшек
    all_pics = os.listdir(current_backs_dir)
    for pic in all_pics:
        print(current_backs_dir + pic)
        print(current_previews_dir + pic)

        # создание объекта
        try:
            image = Image.open(current_backs_dir + pic)
            image = crop_max_square(image).resize((MAX_SIZE), Image.LANCZOS)
            image.save(current_previews_dir + pic, optimize=True, quality=85)
        except PermissionError:
            print('oops')
