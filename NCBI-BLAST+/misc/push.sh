#!/bin/bash

# After BLAST db download complet remove the old stuff and replace with updated contents
# Not doing FASTA files anymore


BLAST=/share/db/blast
UPDATE=${BLAST}/mirror/update

# Remove the old stuff

rm -f ${BLAST}/db/*
#rm -f ${BLAST}/fasta/*
rm -f ${BLAST}/matrices/*

# Move the new stuff

mv ${UPDATE}/db/* ${BLAST}/db 
#mv ${UPDATE}/fasta/* ${BLAST}/fasta
mv ${UPDATE}/matrices/* ${BLAST}/matrices 

# Make sure permissions are correct


