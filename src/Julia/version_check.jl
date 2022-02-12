
function version_this_pkg()
    v = PkgVersion.Version(LVServer)
    return (; major=v.major, minor=v.minor, patch=v.patch)
end

function trunc_v(v)
    return VersionNumber(v.major, v.minor, v.patch) # v # TODO maj.min.patch
end

function check_pkg_versions(;LV_v, LVServer_current, LVServer_min)

    LV_v = VersionNumber(NamedTuple(LV_v)...)
    LVServer_min = VersionNumber(NamedTuple(LVServer_min)...)
    LVServer_remote_current = VersionNumber(NamedTuple(LVServer_current)...)

    LVServer_localv = PkgVersion.Version(LVServer)

    @show LV_v LVServer_localv LVServer_min LVServer_remote_current

    LVServer_incompat =  LVServer_localv < LVServer_min
    LV_incompat = LV_v < LabVIEW0_LOCAL_MIN

    LVServer_OK = LVServer_remote_current == trunc_v(LVServer_localv)
    LV_OK = trunc_v(LabVIEW0_LOCAL_CURRENT) == LV_v

    if LVServer_incompat
        err_msg = "The LVServer package version on this Julia server is $LVServer_localv. \
        At least $LVServer_min is expected by LabVIEW0 client."
    end

    if LV_incompat
        err_msg = "The version of LabVIEW0 client (or of the currently used LV2Julia_core.lvlib) is $LV_v. \
        At least $LabVIEW0_LOCAL_MIN is expected by LVServer package version on this Julia server"
    end

    if (LVServer_incompat | LV_incompat)
        @warn err_msg # for local display on the server
        throw(ErrorException(err_msg)) # returned to the LV client
    end

    if !LVServer_OK
        warn_msg = "The LVServer package version on this Julia server is $LVServer_localv. \
        According to LabVIEW0 client, $LVServer_remote_current is available, please consider LVServer update."
    end

    if !LV_OK
        warn_msg = "The version of LabVIEW0 client (or of the currently used LV2Julia_core.lvlib) is $LV_v. \
        According to LVServer package on this Julia server, $LabVIEW0_LOCAL_CURRENT  is available, \
        please consider LabVIEW0 update"
    end

    all_current = (LVServer_OK & LV_OK)
    if !all_current
        @warn warn_msg # for local display on the server
    end
    v = LVServer_localv
    return (;all_current, LVServer_v=(; major=v.major, minor=v.minor, patch=v.patch))

end

# lvnt_err = (; LV_v=(major=0, minor=1, patch=3), LVServer_current=(major=4, minor=5, patch=6), LVServer_min=(major=0, minor=3, patch=0));
# lvnt = (; LV_v=(major=0, minor=2, patch=1), LVServer_current=(major=4, minor=5, patch=6), LVServer_min=(major=0, minor=2, patch=0));
# lvjs = JSON3.write(lvnt);
# lvnt1 = lvnt1=JSON3.read(lvjs);
