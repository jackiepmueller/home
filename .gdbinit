set disassembly-flavor intel

python
import sys
#sys.path.insert(0, '/home/zcersovsky/Boost-Pretty-Printer')
#sys.path.insert(0, '/opt/bats/share/gcc-4.8.2/python')
sys.path.insert(0, '/home/jmueller/source/gdb/python/')

#from boost.printers import register_printer_gen
#register_printer_gen(None)
#import boost
#boost.register_printers(boost_version=(1,66,0))

#from libstdcxx.v6.printers import register_libstdcxx_printers
#register_libstdcxx_printers(None)

from bats.printers import register_bats_printers
register_bats_printers(None)

import bats.commands # for wgrep-print

end
