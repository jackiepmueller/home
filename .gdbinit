set disassembly-flavor intel
set print pretty on

python
import sys
sys.path.insert(0, '/opt/rh/devtoolset-11/root/usr/share/gdb/python/')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end

# ignore c++ internals
skip -gfi opt/rh/devtoolset-11/root/usr/include/c++/11/bits/*.h

python
import sys
sys.path.insert(0, '/home/jmueller/source/gdb/python/')
from bats.printers import register_bats_printers
register_bats_printers(None)
import bats.commands # for wgrep-print
end

#python
#import sys
#sys.path.insert(1, '/src/Boost-Pretty-Printer')
#import boost
#boost.register_printers(boost_version=(1,76,0))
#end
