module LVServer

using ZMQ, JSON3, ImageCore, Colors, PkgVersion

# version of the communication protocoll: First, and, presumably, the last as well
const PROTOC_V = 0x01

# update these constants on update of any of the packages!
const LabVIEW0_LOCAL_CURRENT = v"0.3.0"
const LabVIEW0_LOCAL_MIN = v"0.2.0"

include("./Julia/ZMQ-server.jl")

# see setglobals() and get_script_path() using these globals
scriptexists = false
scriptOK = false
scriptexcep = nothing
# see setreorderbytes()
reorderbytes = :undefined

export server_0mq4lv, get_script_path, setglobals, setreorderbytes, get_LVlib_path # functions
export scriptexists, scriptOK, scriptexcep # global variables

end
