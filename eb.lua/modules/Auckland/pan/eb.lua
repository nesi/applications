local EB = '/share/easybuild'
local OS = 'RHEL6.3'

local io = require "io"

whatis('Make available the eb command for building with EasyBuild')
add_property("lmod", "sticky")  -- so "purge --force" required

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

if not os.getenv('MODULEPATH'):find(prefix) then
   LmodError("MODULEPATH doesn't match detected architecture ", HARDWARE, ' on ', capture('hostname'))
end

-- Make eb findable
local pylib = capture([[
/usr/bin/python2 -c "import distutils.sysconfig;print distutils.sysconfig.get_python_lib(prefix='/share/easybuild/installation');"
]])
prepend_path('PYTHONPATH', pylib)
prepend_path('PATH', pathJoin(EB, 'installation/bin/'))

-- Other sharable EB settings for fetch, search etc.
setenv('EASYBUILD_SOURCEPATH', pathJoin(EB, 'src'))
setenv('EASYBUILD_PREFIX', prefix)
setenv('EASYBUILD_MODULES_TOOL', 'Lmod')

-- Unsharable EB build and install settings
if os.getenv('USER') ~= 'nesi.apps' then
   local home = os.getenv('HOME')
   prefix = pathJoin(home, 'easybuildinstall', HARDWARE)
end
setenv('EASYBUILD_INSTALLPATH', prefix)
setenv('EASYBUILD_BUILDPATH', pathJoin(prefix, 'build'))
setenv('EASYBUILD_TMP_LOGDIR', pathJoin(prefix, 'log'))
   

