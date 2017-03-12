import os, sys
from glob import glob
from math import floor
import numpy as np

TRAIN_SPLIT = 0.9

curr_dir = os.getcwd()
data_dir = os.environ['DATA_DIR']

os.chdir(data_dir)

drivers = {}
classes = set()
nb_img = 0
with open('driver_imgs_list.csv') as f:
    for line in f:
        if nb_img == 0:
            nb_img += 1
            continue
        nb_img += 1
        d, c, fname = line.split(',')
        d = d.strip()
        c = c.strip()
        fname = fname.strip()
        classes.add(c)
        if d not in drivers:
            drivers[d] = {}
        if c not in drivers[d]:
            drivers[d][c] = []
        drivers[d][c].append(fname)

# g = glob("*.jpg")
# nb_img = len([name for name in os.listdir(data_dir) if os.path.isfile(os.path.join(data_dir, name))])
nb_train = floor(TRAIN_SPLIT * nb_img)

nb_valid = 0
valid_files = {}
while nb_valid < nb_img - nb_train:
    train_drivers = drivers.keys()
    if len(train_drivers) == 0:
        print("huh")
        break
    d = np.random.choice(train_drivers)
    valid_files.update(drivers[d])

    nb_valid += sum([len(cs) for cs in drivers[d].values()])
    del drivers[d]

nb_train = nb_img - nb_valid
print("nb_img: {2}, nb_train: {0}, nb_valid: {1}".format(nb_train, nb_valid, nb_img))

try:
    for c in classes:
        # os.mkdir("train/" + c)
        os.makedirs("valid/" + c)
except OSError as e:
    print(e.message)

for c, fnames in valid_files.iteritems():
    for f in fnames:
        os.rename(os.path.join("train", c, f), os.path.join("valid", c, f))

