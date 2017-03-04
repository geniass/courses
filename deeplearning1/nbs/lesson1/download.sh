export DATA_DIR=`pwd`/data
mkdir $DATA_DIR
cd $DATA_DIR

# mkdir models
# wget http://www.platform.ai/models/vgg16.h5 -O models/vgg16.h5

if [ ! -f test.zip ]; then
	kg download -u aricroock@gmail.com -p "${password}" -c dogs-vs-cats-redux-kernels-edition -f "test.zip"
fi
if [ ! -f train.zip ]; then
	kg download -u aricroock@gmail.com -p "${password}" -c dogs-vs-cats-redux-kernels-edition -f "train.zip"
fi

unzip -q train.zip
unzip -q test.zip

rm train.zip
rm test.zip


mkdir valid
mkdir results
mkdir -p sample/train
mkdir -p sample/test
mkdir -p sample/valid
mkdir -p sample/results
mkdir -p test/unknown

# move 2000 files to validation
mv `find $DATA_DIR/train -type f | shuf -n 2000` valid/

# copy 200 files for the sample training dataset
cp `find $DATA_DIR/train -type f | shuf -n 200` sample/train
# sample validation dataset
cp `find $DATA_DIR/valid -type f | shuf -n 50` sample/valid

# rearrange data files
rearrange () {
    mkdir cats
    mkdir dogs
    mv cat.*.jpg cats/
    mv dog.*.jpg dogs/
}

cd $DATA_DIR/sample/train
rearrange

cd $DATA_DIR/sample/valid
rearrange

cd $DATA_DIR/train
rearrange

cd $DATA_DIR/valid
rearrange

cd $DATA_DIR/test
mv *.jpg unknown/
