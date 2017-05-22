# FindLive555
#
# Find the Live555 Streaming Media Libraries.
#
#=============================================================================
# Copyright 2006-2009 Kitware, Inc.
# Copyright 2009-2011 Mathieu Malaterre <mathieu.malaterre@gmail.com>
# Copyright 2015 Alexander Lamaison <alexander.lamaison@gmail.com>
# Copyright 2017 Ernesto Varoli <ernesto.varoli@gmail.com>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

if(HUNTER_STATUS_DEBUG)
  message("[hunter] Custom FindLive555 module")
endif()

# Support preference of static libs by adjusting CMAKE_FIND_LIBRARY_SUFFIXES
if(LIVE555_USE_STATIC_LIBS)
  set(_live555_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})
  if(WIN32)
    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
  else()
    set(CMAKE_FIND_LIBRARY_SUFFIXES .a )
  endif()
endif()

find_path(LIVE555_INCLUDE_DIR
  NAMES
    liveMedia/Media.hh
  HINTS
    "${LIVE555_ROOT}"
  PATH_SUFFIXES
    include
)

if(WIN32 AND NOT CYGWIN)
  # TODO
else()

  find_library(LIVE555_LIVEMEDIA_LIBRARY
    NAMES
      liveMedia
    HINTS
      "${LIVE555_ROOT}"
    PATH_SUFFIXES
      lib
  )

  #find_library(OPENSSL_CRYPTO_LIBRARY
  #  NAMES
  #    crypto
  #  HINTS
  #    "${OPENSSL_ROOT}"
  #  PATH_SUFFIXES
  #    lib
  #)

  #mark_as_advanced(OPENSSL_CRYPTO_LIBRARY OPENSSL_SSL_LIBRARY)
  mark_as_advanced(LIVE555_LIVEMEDIA_LIBRARY)

  # compat defines
  set(LIVE555_LIVEMEDIA_LIBRARIES ${LIVE555_LIVEMEDIA_LIBRARY} ${CMAKE_DL_LIBS})
  set(LIVE555_GROUPSOCK_LIBRARIES ${LIVE555_GROUPSOCK_LIBRARY} ${CMAKE_DL_LIBS})

  set(LIVE555_LIBRARIES ${LIVE555_LIVEMEDIA_LIBRARY} ${LIVE555_GROUPSOCK_LIBRARY} ${CMAKE_DL_LIBS})

endif()

#function(from_hex HEX DEC)
#  string(TOUPPER "${HEX}" HEX)
#  set(_res 0)
#  string(LENGTH "${HEX}" _strlen)
#
#  while (_strlen GREATER 0)
#    math(EXPR _res "${_res} * 16")
#    string(SUBSTRING "${HEX}" 0 1 NIBBLE)
#    string(SUBSTRING "${HEX}" 1 -1 HEX)
#    if (NIBBLE STREQUAL "A")
#      math(EXPR _res "${_res} + 10")
#    elseif (NIBBLE STREQUAL "B")
#      math(EXPR _res "${_res} + 11")
#    elseif (NIBBLE STREQUAL "C")
#      math(EXPR _res "${_res} + 12")
#    elseif (NIBBLE STREQUAL "D")
#      math(EXPR _res "${_res} + 13")
#    elseif (NIBBLE STREQUAL "E")
#      math(EXPR _res "${_res} + 14")
#    elseif (NIBBLE STREQUAL "F")
#      math(EXPR _res "${_res} + 15")
#    else()
#      math(EXPR _res "${_res} + ${NIBBLE}")
#    endif()

#    string(LENGTH "${HEX}" _strlen)
#  endwhile()

#  set(${DEC} ${_res} PARENT_SCOPE)
#endfunction()

#if(LIVE555_INCLUDE_DIR AND EXISTS "${OPENSSL_INCLUDE_DIR}/openssl/opensslv.h")
#  file(STRINGS "${OPENSSL_INCLUDE_DIR}/openssl/opensslv.h" openssl_version_str
#    REGEX "^#[\t ]*define[\t ]+OPENSSL_VERSION_NUMBER[\t ]+0x([0-9a-fA-F])+.*")

#  string(COMPARE EQUAL "${openssl_version_str}" "" _is_empty)
#  if(_is_empty)
#    message(
#        FATAL_ERROR
#        "Incorrect OPENSSL_VERSION_NUMBER define in header"
#        ": ${OPENSSL_INCLUDE_DIR}/openssl/opensslv.h"
#    )
#  endif()

  # The version number is encoded as 0xMNNFFPPS: major minor fix patch status
  # The status gives if this is a developer or prerelease and is ignored here.
  # Major, minor, and fix directly translate into the version numbers shown in
  # the string. The patch field translates to the single character suffix that
  # indicates the bug fix state, which 00 -> nothing, 01 -> a, 02 -> b and so
  # on.

 # string(REGEX REPLACE "^.*OPENSSL_VERSION_NUMBER[\t ]+0x([0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F]).*$"
  #  "\\1;\\2;\\3;\\4;\\5" OPENSSL_VERSION_LIST "${openssl_version_str}")
  #list(GET OPENSSL_VERSION_LIST 0 OPENSSL_VERSION_MAJOR)
  #list(GET OPENSSL_VERSION_LIST 1 OPENSSL_VERSION_MINOR)
  #from_hex("${OPENSSL_VERSION_MINOR}" OPENSSL_VERSION_MINOR)
  #list(GET OPENSSL_VERSION_LIST 2 OPENSSL_VERSION_FIX)
  #from_hex("${OPENSSL_VERSION_FIX}" OPENSSL_VERSION_FIX)
  #list(GET OPENSSL_VERSION_LIST 3 OPENSSL_VERSION_PATCH)

  #if (NOT OPENSSL_VERSION_PATCH STREQUAL "00")
  #  from_hex("${OPENSSL_VERSION_PATCH}" _tmp)
  #  # 96 is the ASCII code of 'a' minus 1
  #  math(EXPR OPENSSL_VERSION_PATCH_ASCII "${_tmp} + 96")
  #  unset(_tmp)
  #  # Once anyone knows how OpenSSL would call the patch versions beyond 'z'
  #  # this should be updated to handle that, too. This has not happened yet
  #  # so it is simply ignored here for now.
  #  string(ASCII "${OPENSSL_VERSION_PATCH_ASCII}" OPENSSL_VERSION_PATCH_STRING)
  #endif ()

#  set(OPENSSL_VERSION "${OPENSSL_VERSION_MAJOR}.${OPENSSL_VERSION_MINOR}.${OPENSSL_VERSION_FIX}${OPENSSL_VERSION_PATCH_STRING}")
#endif ()

include(FindPackageHandleStandardArgs)

message(WARNING "remove version set")
set(LIVE555_VERSION "2.4.1")

if (LIVE555_VERSION)
  find_package_handle_standard_args(Live555
    REQUIRED_VARS
      LIVE555_LIBRARIES
      LIVE555_INCLUDE_DIR
    VERSION_VAR
      LIVE555_VERSION
    FAIL_MESSAGE
      "Could NOT find Live555 Streaming Media, try to set the path to Live555 root folder in the system variable LIVE555_ROOT_DIR"
  )
else ()
  find_package_handle_standard_args(Live555 "Could NOT find Live555 Streaming Media, try to set the path to Live555 root folder in the system variable LIVE_ROOT_DIR"
    LIVE555_LIBRARIES
    LIVE555_INCLUDE_DIR
  )
endif ()

mark_as_advanced(LIVE555_INCLUDE_DIR LIVE555_LIBRARIES)

if(LIVE555_FOUND)
  if(NOT TARGET Live555::LiveMedia AND 
     EXISTS "${LIVE555_LIVEMEDIA_LIBRARY}")
    add_library(Live555::LiveMedia UNKNOWN IMPORTED)
    set_target_properties(Live555::LiveMedia PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LIVE555_INCLUDE_DIR}")
    set_target_properties(Live555::LiveMedia PROPERTIES
        INTERFACE_LINK_LIBRARIES "${CMAKE_DL_LIBS}")
    if(EXISTS "${LIVE555_LIVEMEDIA_LIBRARY}")
      set_target_properties(Live555::LiveMedia PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES "C++"
        IMPORTED_LOCATION "${LIVE555_LIVEMEDIA_LIBRARY}")
    endif()
    #if(EXISTS "${LIB_EAY_LIBRARY_DEBUG}")
    #  set_property(TARGET OpenSSL::Crypto APPEND PROPERTY
    #    IMPORTED_CONFIGURATIONS DEBUG)
    #  set_target_properties(OpenSSL::Crypto PROPERTIES
    #    IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
    #    IMPORTED_LOCATION_DEBUG "${LIB_EAY_LIBRARY_DEBUG}")
    #endif()
    #if(EXISTS "${LIB_EAY_LIBRARY_RELEASE}")
    #  set_property(TARGET OpenSSL::Crypto APPEND PROPERTY
    #    IMPORTED_CONFIGURATIONS RELEASE)
    #  set_target_properties(OpenSSL::Crypto PROPERTIES
    #    IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
    #    IMPORTED_LOCATION_RELEASE "${LIB_EAY_LIBRARY_RELEASE}")
    #endif()
  endif()

  #if(NOT TARGET OpenSSL::SSL AND
  #    (EXISTS "${OPENSSL_SSL_LIBRARY}" OR
  #      EXISTS "${SSL_EAY_LIBRARY_DEBUG}" OR
  #      EXISTS "${SSL_EAY_LIBRARY_RELEASE}")
  #    )
  #  add_library(OpenSSL::SSL UNKNOWN IMPORTED)
  #  set_target_properties(OpenSSL::SSL PROPERTIES
  #    INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")
  #  if(EXISTS "${OPENSSL_SSL_LIBRARY}")
  #    set_target_properties(OpenSSL::SSL PROPERTIES
  #      IMPORTED_LINK_INTERFACE_LANGUAGES "C"
  #      IMPORTED_LOCATION "${OPENSSL_SSL_LIBRARY}")
  #  endif()
  #  if(EXISTS "${SSL_EAY_LIBRARY_DEBUG}")
  #    set_property(TARGET OpenSSL::SSL APPEND PROPERTY
  #      IMPORTED_CONFIGURATIONS DEBUG)
  #    set_target_properties(OpenSSL::SSL PROPERTIES
  #      IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  #      IMPORTED_LOCATION_DEBUG "${SSL_EAY_LIBRARY_DEBUG}")
  #  endif()
  #  if(EXISTS "${SSL_EAY_LIBRARY_RELEASE}")
  #    set_property(TARGET OpenSSL::SSL APPEND PROPERTY
  #      IMPORTED_CONFIGURATIONS RELEASE)
  #    set_target_properties(OpenSSL::SSL PROPERTIES
  #      IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  #      IMPORTED_LOCATION_RELEASE "${SSL_EAY_LIBRARY_RELEASE}")
  #  endif()
  #  if(TARGET OpenSSL::Crypto)
  #    set_target_properties(OpenSSL::SSL PROPERTIES
  #      INTERFACE_LINK_LIBRARIES "OpenSSL::Crypto;${CMAKE_DL_LIBS}")
  #  else()
  #    set_target_properties(OpenSSL::SSL PROPERTIES
  #      INTERFACE_LINK_LIBRARIES "${CMAKE_DL_LIBS}")
  #  endif()
  #endif()
endif()

# Restore the original find library ordering
if(LIVE555_USE_STATIC_LIBS)
  set(CMAKE_FIND_LIBRARY_SUFFIXES ${_live555_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES})
endif()
