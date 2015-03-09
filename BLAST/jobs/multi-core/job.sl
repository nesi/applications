#!/bin/bash
#SBATCH --job-name       BLAST
#SBATCH --cpus-per-task  16               # or 12 or 24
#SBATCH --time           02:30:00         # Allow 100 CPU hrs / GB of query sequences.
#SBATCH --mem-per-cpu    5G               # Include allowance for RAM disk containing database.
#SBATCH --constraint     avx              # Avoid the slow "bigmem" machines.

# Takes one argument, the FASTA file of query sequences.
QUERIES=$1
FORMAT="6 qseqid qstart qend qseq sseqid sgi sacc sstart send sseq staxids sscinames scomnames sblastnames sskingdoms stitle length evalue bitscore"
BLASTOPTS="-evalue 0.05 -max_target_seqs 10"
BLASTAPP=blastn
DB=nt
#BLASTAPP=blastx
#DB=nr

# Keep the database in RAM, which is important for databases over 4GB in the shared GPFS filesystem.
cp $BLASTDB/{$DB,taxdb}* $SHM_DIR/ 
export BLASTDB=$SHM_DIR

# Single node multithreaded BLAST.
srun $BLASTAPP $BLASTOPTS -db $DB -query $QUERIES -outfmt "$FORMAT" -out $QUERIES.$DB.$BLASTAPP -num_threads $SLURM_CPUS_PER_TASK
