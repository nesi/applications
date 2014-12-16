#!/bin/bash

BLAST=/gpfs1m/apps/db/blast
LOCAL=${BLAST}/mirror
UPDATE=${LOCAL}/update
REMOTE=ftp://ftp.ncbi.nih.gov/blast
MANIFEST=${LOCAL}/manifest.txt

CHECK_DB_LISTING=0; CHECK_DB_MD5=0; CHECK_DB_EXTRACT=0;
CHECK_FASTA_LISTING=0; CHECK_FASTA_MD5=0; CHECK_FASTA_EXTRACT=0;
CHECK_MATRIX_LISTING=0;

COUNT_LIMIT=30

function check_listing()
{
    echo "Checking number of files in $1 from $2" >> ${MANIFEST}
    cd ${1}
    rm index.*
    wget --no-remove-listing ${2}
    cat .listing | rev | cut -f1 -d " " | rev | tr -d '\r' | grep ".tar.gz\|.md5" | while read line; do
   	if [ ! -e ${line} ]; then
 		echo "${line} was not found in ${1}" >> ${MANIFEST}
        	echo "Downloading ${2}${line}" >> ${MANIFEST}
        	wget ${2}${line}
    		echo "Downloaded missing file, need to recheck..." >> ${MANIFEST}
		CHECK=0
		return
    	fi
    done
    echo "All files accounted for" >> ${MANIFEST}
    CHECK=1
}

function check_files()
{
    echo "Checking files in ${1}, see ${MANIFEST} for details"
    echo "Checking files in ${1}" >> ${MANIFEST}
    cd ${1}
    echo "Location: ${1}" >> ${MANIFEST}
    for file in $(find . -maxdepth 1 -name "*.md5"); do
	md5sum -c $file >> ${MANIFEST}
	md5return=$?
	if [ $md5return -ne 0 ]; then
		echo "Removing $file and ${file%.md5}"	
		echo "Removing $file and ${file%.md5}" >> ${MANIFEST}
		rm $file ${file%.md5}
		CHECK=0
		break
	fi
    done
}

function update_db()
{	

	# Download the db files
	echo "Downloading preformatted database ..." >> ${MANIFEST}
	cd ${LOCAL}/db
	wget -r -l 1 -np -nH --cut-dirs=2 -N --reject="README" ${REMOTE}/db/
	
	# Check that all the files have been downloaded
    	check_listing ${LOCAL}/db ${REMOTE}/db/
        if [ $CHECK -eq 1 ]; then
		# Check md5 sums
		check_files ${LOCAL}/db
		if [ $CHECK -eq 1 ];then
        		echo "Ready to extract BLAST DB" >> ${MANIFEST}
			# Extract the db
        		if [ $CHECK -eq 1 ]; then
        		       echo "Extracting BLAST database ..." >> ${MANIFEST}
        		       find ${LOCAL}/db/ -maxdepth 1 -name "*.tar.gz" -exec date \; -exec tar -zvxf {} --overwrite -C ${UPDATE}/db \; >> ${MANIFEST}
        		else
        		       let COUNT++
        		       return
        		fi				
		else
			let COUNT++
               		return
		fi
	else
		let COUNT++
		return
	fi
}

function update_fasta()
{
        # Download the fasta files
        echo "Downloading FASTA database ..." >> ${MANIFEST}
        cd ${LOCAL}/fasta
        wget -r -l 1 -np -nH --cut-dirs=3 -N ${REMOTE}/db/FASTA/

        # Check that all the files have been downloaded
        check_listing ${LOCAL}/fasta ${REMOTE}/db/FASTA/	
        if [ $CHECK -eq 1 ]; then
                # Check md5 sums
                check_files ${LOCAL}/fasta
                if [ $CHECK -eq 1 ];then
                        echo "Ready to extract FASTA files" >> ${MANIFEST}
			for f in $(find ${LOCAL}/fasta/ -maxdepth 1 -name "*.gz"); do
				base=$(basename $f .gz)
				echo $base >> ${MANIFEST}
				gunzip -c $f > ${UPDATE}/fasta/$base
			done
                else
                        let COUNT++
                        return
                fi
        else    
                let COUNT++
                return
        fi
}

function update_matrices()
{
        # Download the matrices
        echo "Downloading matrices ..." >> ${MANIFEST}
        cd ${LOCAL}/matrices
        wget -r -l 1 -np -nH --cut-dirs=2 -N ${REMOTE}/matrices/

        # Check that all the files have been downloaded
        check_listing ${LOCAL}/matrices ${REMOTE}/matrices/
        if [ $CHECK -eq 1 ]; then
		echo "Matrices downloaded" >> ${MANIFEST}
		cp ${LOCAL}/matrices/* ${UPDATE}/matrices
        else      
                let COUNT++
                return
        fi
}

# Clear the manifest
echo "" > ${MANIFEST}

# Update the binary database

COUNT=0; CHECK=0; 
while [ $CHECK -ne 1 ]; do
	update_db
    # Check for long unbound loops
    if [ $COUNT -eq $COUNT_LIMIT ]; then
            mail -s "BLAST Database Problem" s.ansari@auckland.ac.nz < ${MANIFEST}
            exit 1
    fi    
done

echo "Finished downloading preformatted database" >> ${MANIFEST}

# Update the FASTA database
# Considered unnecessary after discussion with Peter Maxwell 26/11/2013
#COUNT=0; CHECK=0; 
#while [ $CHECK -ne 1 ]; do
#    update_fasta
#    # Check for long unbound loops
#    if [ $COUNT -eq $COUNT_LIMIT ]; then
#            mail -s "BLAST Database Problem" s.ansari@auckland.ac.nz < ${MANIFEST}
#            exit 1
#    fi    
#done

#echo "Finished downloading FASTA db" >> ${MANIFEST}

# Update the matrices

COUNT=0; CHECK=0; 
while [ $CHECK -ne 1 ]; do
    update_matrices
    # Check for long unbound loops
    if [ $COUNT -eq $COUNT_LIMIT ]; then
            mail -s "BLAST Database Problem" s.ansari@auckland.ac.nz < ${MANIFEST}
            exit 1
    fi    
done

echo "Finished downloading matrices" >> ${MANIFEST}

# Check database integrity
#module load blast+/2.2.26 
#/gpfs1m/apps/apps/blast+/bin/blastdbcheck -dir ${UPDATE}/db -full -verbosity 2 >> ${MANIFEST}

echo "Finished" >> ${MANIFEST}
mail -s "BLAST Database Download Complete" s.ansari@auckland.ac.nz < ${MANIFEST}
