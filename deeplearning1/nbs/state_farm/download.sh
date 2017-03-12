# export DATA_DIR=`pwd`/data
mkdir $DATA_DIR
cd $DATA_DIR

# mkdir models
# wget http://www.platform.ai/models/vgg16.h5 -O models/vgg16.h5

if [ ! -f test.zip ]; then
	kg download -u aricroock@gmail.com -p "${password}" -c state-farm-distracted-driver-detection -f "imgs.zip"
fi
if [ ! -f train.zip ]; then
	kg download -u aricroock@gmail.com -p "${password}" -c state-farm-distracted-driver-detection -f "driver_imgs_list.csv.zip"
fi

unzip -q imgs.zip
unzip -q driver_imgs_list.csv.zip

#rm imgs.zip
#rm driver_imgs_list.csv.zip

DATA_DIR=$DATA_DIR python mkdata.py

mkdir -p test/unknown

cd $DATA_DIR/test
mv *.jpg unknown/
