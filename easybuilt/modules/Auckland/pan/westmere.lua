local EB='/share/easybuild'
local OS='RHEL6.3'

local io = require "io"

whatis('Make available the modules built with EasyBuild')

family('architecture')

local HARDWARE = 'westmere'

append_path('MODULEPATH', pathJoin(EB, OS, HARDWARE, 'modules', 'all'))
