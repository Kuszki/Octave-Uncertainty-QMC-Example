#!/bin/bash

[ ! -d 'wyniki' ] && mkdir 'wyniki'
[ ! -d 'obrazki' ] && mkdir 'obrazki'

parallel -j 8 --colsep='\t' --arg-file=params.dat octave {1} {2} {3} {4} | tee ../wyniki/out.txt
