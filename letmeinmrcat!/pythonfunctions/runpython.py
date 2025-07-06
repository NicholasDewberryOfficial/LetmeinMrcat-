#!/usr/env/bin python

import json
from urllib import request, parse
import argparse

def queue_prompt(prompt):
    p = {"prompt": prompt}
    data = json.dumps(p).encode('utf-8')
    req =  request.Request("http://127.0.0.1:8188/prompt", data=data)
    request.urlopen(req)

parser = argparse.ArgumentParser()
parser.add_argument("--file", type=str, default=None, help="Prompt file to use.")
args = parser.parse_args()

if args.file is None:
    print("Please specify a prompt file with --file.")
    exit()

# load json file
with open(args.file) as f:
    prompt = json.load(f)

queue_prompt(prompt)
