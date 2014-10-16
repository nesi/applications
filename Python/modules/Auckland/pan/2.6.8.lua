whatis([[An environment in which Python 2.6.8 is the default python ]])
conflict("Python")
setenv("VIRTUAL_ENV","/share/apps/Python/noarch/2.6.8/gcc-4.4.6")
prepend_path{"PATH","/share/apps/Python/noarch/2.6.8/gcc-4.4.6/bin",delim=":",priority="0"}
if (mode() == "load") then
  LmodMessage("Warning: The Python/2.6.8 module is deprecated, please switch to a newer one such as Python/2.7.6-goolf-1.5.14")
end
