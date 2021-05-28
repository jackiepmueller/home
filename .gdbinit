set disassembly-flavor intel

python
import sys
sys.path.insert(0, '/opt/rh/devtoolset-8/root/usr/share/gdb/python/')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end

python
import sys
sys.path.insert(0, '/home/jmueller/source/gdb/python/')
from bats.printers import register_bats_printers
register_bats_printers(None)
import bats.commands # for wgrep-print
end

python
import sys
sys.path.insert(1, '/src/Boost-Pretty-Printer')
import boost
boost.register_printers(boost_version=(1,76,0))
end

define n
    set logging file /dev/null
    set logging redirect on
    set logging on
    next
    set logging off
    display
end

define s
    set logging file /dev/null
    set logging redirect on
    set logging on
    step
    set logging off
    display
end

define u
    set logging file /dev/null
    set logging redirect on
    set logging on
    up
    set logging off
    display
end

define do
    set logging file /dev/null
    set logging redirect on
    set logging on
    down
    set logging off
    display
end
