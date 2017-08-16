rm photos/resized_noised/34.png
python tools/process.py \
  --input_dir photos/noised \
  --operation resize \
  --output_dir photos/resized_noised \
  --size 2560
  
python tools/process.py \
  --input_dir photos/original \
  --operation resize \
  --output_dir photos/resized_original \
  --size 2560

python tools/process.py \
  --input_dir photos/resized_noised \
  --b_dir photos/resized_original \
  --operation combine \
  --output_dir photos/combined \
  --size 2560
  
python tools/split.py \
  --dir photos/combined \
  --size 2560
  
python pix2pix.py \
  --mode train \
  --output_dir training_results \
  --max_epochs 50 \
  --input_dir photos/combined \
  --which_direction AtoB \
  --batch_size 2 \
  --scale_size 2560

python pix2pix.py \
  --mode export \
  --output_dir server/models/denoiser \
  --checkpoint training_results
    
python server/tools/process-local.py \
    --model_dir server/models/denoiser \
    --input_file photos/resized_noised/34.png \
    --output_file output.png
    
# python tools/process-remote.py \
#     --input_file static/14.png \
#     --url http://dobby.traderslab.in/denoiser \
#     --output_file output2.png
  
  
