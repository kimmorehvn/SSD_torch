# create env
export MODEL_NAME="ssd"
conda clean --all --force-pkgs-dir
conda env create --name $MODEL_NAME
conda activate $MODEL_NAME
update-moreh --torch 1.7.1 --force

# install requirements
echo "installing requirements.."
python -m pip install yacs vizer opencv-python tqdm tensorboardX
# ....

# prepare data
echo "Checking dataset.."
# /bin/bash
# > get_voc.sh
VOC_ROOT="./voc"
cd $VOC_ROOT
wget https://pjreddie.com/media/files/VOCtrainval_11-May-2012.tar
wget https://pjreddie.com/media/files/VOCtrainval_06-Nov-2007.tar
wget https://pjreddie.com/media/files/VOCtest_06-Nov-2007.tar
tar xf VOCtrainval_11-May-2012.tar
tar xf VOCtrainval_06-Nov-2007.tar
tar xf VOCtest_06-Nov-2007.tar
# ....
 
# training
echo "training $MODEL_NAME.."
VOC_ROOT="./voc" python train.py --config-file configs/vgg_ssd300_voc0712.yaml
# choose one of model name below:
# VOC_ROOT=/data/work/dataset/VOCdevkit python train.py --config-file configs/mobilenet_v3_ssd320_voc0712.yaml
# VOC_ROOT=/data/work/dataset/VOCdevkit python train.py --config-file configs/mobilenet_v2_ssd320_voc0712.yaml
# VOC_ROOT=/data/work/dataset/VOCdevkit python train.py --config-file configs/efficient_net_b3_ssd300_voc0712.yaml
# Choose one of them
# ....


# remove env
echo "training done. deleting env.."
conda deactivate $MODEL_NAME
conda remove -n $MODEL_NAME