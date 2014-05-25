local EB='/share/easybuild'
local OS='RHEL6.3'

local io = require "io"

whatis('Make available the modules built with EasyBuild')

family('architecture')

local HARDWARE='sandybridge'
for line in io.lines('/proc/cpuinfo') do
	if line:sub(1,5)=='flags' then 
	    if not line:find('avx') then 
			HARDWARE = 'westmere'
			break
		end
	end
end

append_path('MODULEPATH', pathJoin(EB, OS, HARDWARE, 'modules', 'all'))
