#! /bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH -p gpu
#SBATCH --gres gpu:4
#SBATCH --partition=gpu_h100
#SBATCH --time=01-00:00:00

#SBATCH -o /gpfs/work4/0/gus20642/dwu18/log/out.s1.%j.o
#SBATCH -e /gpfs/work4/0/gus20642/dwu18/log/out.s1.%j.e

source activate reward-bench

export HF_HUB_CACHE=/gpfs/work4/0/gus20642/dwu18/cache
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

OPENAI_KEY=xx

### s1, GSM8K, sample 64 ###
OPENAI_API_KEY=$OPENAI_KEY PROCESSOR=gpt-4o-mini lm_eval --model vllm --model_args pretrained=simplescaling/s1-32B,tokenizer=Qwen/Qwen2.5-32B-Instruct,dtype=float32,tensor_parallel_size=4 --tasks gsm8k_cot_self_consistency --batch_size auto --apply_chat_template --output_path s1-32B-agg64 --log_samples --gen_kwargs "max_gen_toks=32768,temperature=1"
