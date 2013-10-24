#!/bin/bash
export MONOLIX=/share/apps/monolix/noarch/4.2.2-standalone2008b-linux64
export MCR_INHIBIT_CTF_LOCK=1
$MONOLIX/bin/Monolix.sh -nowin -p ./warfarin_PK_project.mlxtran -f saem

