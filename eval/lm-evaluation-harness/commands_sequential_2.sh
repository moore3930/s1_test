#! /bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH -p gpu
#SBATCH --gres gpu:2
#SBATCH --partition=gpu_h100
#SBATCH --time=01-00:00:00

#SBATCH -o /gpfs/work4/0/gus20642/dwu18/log/out.s1_NIgnore.%j.o
#SBATCH -e /gpfs/work4/0/gus20642/dwu18/log/out.s1_NIgnore.%j.e

source activate reward-bench

export HF_HUB_CACHE=/gpfs/work4/0/gus20642/dwu18/cache
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

NIgnore=$1
OPENAI_KEY=xx

OPENAI_API_KEY=YOUR_OPENAI_KEY PROCESSOR=gpt-4o-mini lm_eval --model vllm --model_args pretrained=simplescaling/s1-32B,tokenizer=Qwen/Qwen2.5-32B-Instruct,dtype=float32,tensor_parallel_size=8 --tasks aime24_figures,aime24_nofigures,openai_math,gpqa_diamond_openai --batch_size auto --apply_chat_template --output_path forcingignore1wait --log_samples --gen_kwargs "max_gen_toks=32768,max_tokens_thinking=auto,thinking_n_ignore=$NIgnore,thinking_n_ignore_str=Wait"