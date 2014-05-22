local EB = '/share/easybuild'
local OS = 'RHEL6.3'

local io = require "io"

whatis('Make available the eb command and the modules built with EasyBuild')

family('architecture')

local HARDWARE='sandybridge'
for line in io.lines('/proc/cpuinfo') do
	if line:sub(1,5) == 'flags' then 
	    if not line:find('avx') then 
			HARDWARE = 'westmere'
			break
		end
	end
end

local prefix = pathJoin(EB, OS, HARDWARE)
local pylib = capture([[
python -c "import distutils.sysconfig;print distutils.sysconfig.get_python_lib(prefix='/share/easybuild/installation');"
]])

prepend_path('PYTHONPATH', pylib)
prepend_path('PATH', pathJoin(EB, 'installation/bin/'))
prepend_path('MODULEPATH', pathJoin(prefix, 'modules/all'))
prepend_path('LMOD_DEFAULT_MODULEPATH', pathJoin(prefix, 'modules/all'))
setenv('EASYBUILDBUILDPATH', pathJoin(prefix, 'build'))
setenv('EASYBUILDINSTALLPATH', prefix)
setenv('EASYBUILD_PREFIX', prefix)
setenv('EASYBUILD_SOURCEPATH', pathJoin(EB, 'src'))
setenv('EASYBUILD_MODULES_TOOL', 'Lmod')



