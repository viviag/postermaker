#!/bin/bash

postermaker -f png -n githask -s "(800,600)"
postermaker -f png -n githask_t -s "(800,600)" -t another_texts.csv
postermaker -f png -n githask_i -s "(800,600)" -i another_images.csv -c "(144,238,144)"
