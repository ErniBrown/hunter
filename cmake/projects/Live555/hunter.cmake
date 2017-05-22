# !!! DO NOT PLACE HEADER GUARDS HERE !!!

# Load used modules
include(hunter_add_version)
include(hunter_configuration_types)
include(hunter_download)
include(hunter_pick_scheme)
include(hunter_cacheable)

hunter_add_version(
    PACKAGE_NAME
    Live555
    VERSION
    "0.1"
    URL
    "http://www.live555.com/liveMedia/public/live.2017.04.26.tar.gz"
    SHA1
    7bdbae6d8fdea5f050d890449fc8cb622fc2fef4
)

#hunter_configuration_types(libsodium CONFIGURATION_TYPES Release)
#if(MSVC)
#    hunter_pick_scheme(DEFAULT url_sha1_libsodium_msbuild)
#else()
#    hunter_pick_scheme(DEFAULT url_sha1_libsodium_autogen_autotools)
#endif()

hunter_pick_scheme(DEFAULT url_sha1_live555)

#hunter_cacheable(libsodium)
hunter_download(
    PACKAGE_NAME Live555
    #PACKAGE_INTERNAL_DEPS_ID "1"
)
