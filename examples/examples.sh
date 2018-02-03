#!/bin/bash

postermaker -f png -n white -s "(800,600)"
postermaker -f png -n silent -s "(800,600)" -i images.csv
postermaker -f png -n tintless -s "(800,600)" -t another_texts.csv
postermaker -f png -n githask -s "(800,600)" -i images.csv -t texts.csv
postermaker -f png -n githask_t -s "(800,600)" -t another_texts.csv -i images.csv
postermaker -f png -n githask_i -s "(800,600)" -i another_images.csv -c "(144,238,144)" -t texts.csv
