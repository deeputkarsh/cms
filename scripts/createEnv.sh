#!/bin/bash
envFile='.env'
python3 -c "import yaml
import os
import json
with open('buildspec.yml', 'r') as stream:
  sls = yaml.safe_load(stream)
  envs = sls['env']
  if(type(envs) is dict):
    for key in envs.keys():
      if(type(envs[key]) is dict and (key == 'variables' or key == 'parameter-store' or key == 'secrets-manager')):
        for eVars in envs[key].keys():
          envValue=os.getenv(eVars, default = '')
          try:
            # parse and print any json in a single line with single quotes
            print('{0}=\'{1}\''.format(eVars, json.dumps(json.loads(envValue))))
          except:
            print('{0}=\'{1}\''.format(eVars, envValue))
" > $envFile
