local EB='/share/easybuild'
local OS='RHEL6.3'

local io = require "io"
local assert = assert

whatis('Make available the modules built with EasyBuild')

family('architecture')

for line in io.lines('/proc/cpuinfo') do
	if line:sub(1,5)=='flags' and not line:find('avx') then
		LmodError('Found a non-Sandybridge CPU')
	end
end
local HARDWARE = 'sandybridge'

append_path('MODULEPATH', pathJoin(EB, OS, HARDWARE, 'modules', 'all'))
