SRC_MODEL_DIR="/opt/tta/CNA_TTA/output/domainnet-126/source"
MEMO="DOMAINNET"
SUB_MEMO="online_adacontrast_Seed_final"
PORT=10039
SRC_DOMAIN=(real   real    real     sketch   clipart painting painting)
TGT_DOMAIN=(sketch clipart painting painting sketch  real     clipart)
PORTS=(${PORT} ${PORT} ${PORT} ${PORT} ${PORT} ${PORT} ${PORT})

for SEED in 2021 2022 2023
do  
    for i in "${!SRC_DOMAIN[@]}"
    do 
        CUDA_VISIBLE_DEVICES=1,3 python ../main_adacontrast.py \
        seed=${SEED} port=${PORTS[i]} memo=${MEMO} sub_memo=${SUB_MEMO} project="domainnet-126" \
        data.data_root="/mnt/data" data.workers=8 \
        data.dataset="domainnet-126" data.source_domains="[${SRC_DOMAIN[i]}]" data.target_domains="[${TGT_DOMAIN[i]}]" \
        learn.epochs=1 \
        data.batch_size=64 \
        model_src.arch="resnet50" \
        model_tta.src_log_dir=${SRC_MODEL_DIR} \
        learn=targetv1.yaml \
        optim.lr=2e-4 
    done
done 

(54.80+62.28+67.92+65.36+55.38+80.06+61.54)/7
(55.91+62.54+67.87+65.33+55.83+80.68+61.42)/7