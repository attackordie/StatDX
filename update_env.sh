#!/bin/bash

# Step 1: Update the submodules
echo "Updating submodules..."
git submodule update --init --recursive

# Step 2: Update the Conda environment
echo "Updating Conda environment..."

# Activate your environment
source activate textgrad-env

# Install main repository dependencies
if [ -f requirements.txt ]; then
  pip install -r requirements.txt
fi

# Install submodule dependencies
for submodule in $(git config --file .gitmodules --get-regexp path | awk '{ print $2 }'); do
  if [ -f $submodule/requirements.txt ]; then
    pip install -r $submodule/requirements.txt
  fi
done

echo "Conda environment update complete."
