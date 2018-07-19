#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

type realpath &> /dev/null
if [[ $? -ne 0 ]]; then
    realpath() {
        [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
    }
fi

function usage {
    echo "Usage: strip_samba_build.sh <build-dir>"
}

if [[ $# -eq 0 ]]; then
    usage
    exit 1
else
    BUILDDIR=$1
fi

BUILDDIRPATH=`realpath $BUILDDIR`

echo
echo "                                                 _____  "
echo "********************************************    /     \ "
echo "*                                          *   | () () |"
echo "*   WARNING! Some files will be deleted!   *    \  ^  / "
echo "*                                          *     |||||  "
echo "********************************************     |||||  "
echo
echo "Running this script will delete lots of files from "
echo "'${BUILDDIRPATH}',"
echo "leaving only those files that are needed by VFS."
echo
read -p "Are you sure you want to continue? [y/N] " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting process"
    exit 0
fi

set -e
set -x

mkdir $SCRIPTDIR/tmp-samba-dir
mkdir $SCRIPTDIR/tmp-samba-dir/source3
mkdir $SCRIPTDIR/tmp-samba-dir/source3/include
mkdir $SCRIPTDIR/tmp-samba-dir/source3/locking
mkdir $SCRIPTDIR/tmp-samba-dir/source3/lib
mkdir $SCRIPTDIR/tmp-samba-dir/source3/smbd
mkdir $SCRIPTDIR/tmp-samba-dir/libcli
mkdir $SCRIPTDIR/tmp-samba-dir/libcli/util
mkdir $SCRIPTDIR/tmp-samba-dir/libcli/smb
mkdir $SCRIPTDIR/tmp-samba-dir/bin
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default/source3
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default/source3/param
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default/include
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default/librpc
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default/lib
mkdir $SCRIPTDIR/tmp-samba-dir/bin/default/lib/param
mkdir $SCRIPTDIR/tmp-samba-dir/libds
mkdir $SCRIPTDIR/tmp-samba-dir/libds/common
mkdir $SCRIPTDIR/tmp-samba-dir/librpc
mkdir $SCRIPTDIR/tmp-samba-dir/librpc/ndr
mkdir $SCRIPTDIR/tmp-samba-dir/lib
mkdir $SCRIPTDIR/tmp-samba-dir/lib/tevent
mkdir $SCRIPTDIR/tmp-samba-dir/lib/util
mkdir $SCRIPTDIR/tmp-samba-dir/lib/util/charset
mkdir $SCRIPTDIR/tmp-samba-dir/lib/param
mkdir $SCRIPTDIR/tmp-samba-dir/lib/replace
mkdir $SCRIPTDIR/tmp-samba-dir/lib/replace/system
mkdir $SCRIPTDIR/tmp-samba-dir/lib/talloc
mkdir $SCRIPTDIR/tmp-samba-dir/dynconfig
cp $BUILDDIRPATH/source3/include/srvstr.h $SCRIPTDIR/tmp-samba-dir/source3/include/srvstr.h
cp $BUILDDIRPATH/source3/include/sysquotas.h $SCRIPTDIR/tmp-samba-dir/source3/include/sysquotas.h
cp $BUILDDIRPATH/source3/include/proto.h $SCRIPTDIR/tmp-samba-dir/source3/include/proto.h
cp $BUILDDIRPATH/source3/include/util_event.h $SCRIPTDIR/tmp-samba-dir/source3/include/util_event.h
cp $BUILDDIRPATH/source3/include/locking.h $SCRIPTDIR/tmp-samba-dir/source3/include/locking.h
cp $BUILDDIRPATH/source3/include/smb.h $SCRIPTDIR/tmp-samba-dir/source3/include/smb.h
cp $BUILDDIRPATH/source3/include/vfs_macros.h $SCRIPTDIR/tmp-samba-dir/source3/include/vfs_macros.h
cp $BUILDDIRPATH/source3/include/vfs.h $SCRIPTDIR/tmp-samba-dir/source3/include/vfs.h
cp $BUILDDIRPATH/source3/include/smb_macros.h $SCRIPTDIR/tmp-samba-dir/source3/include/smb_macros.h
cp $BUILDDIRPATH/source3/include/smb_perfcount.h $SCRIPTDIR/tmp-samba-dir/source3/include/smb_perfcount.h
cp $BUILDDIRPATH/source3/include/smb_acls.h $SCRIPTDIR/tmp-samba-dir/source3/include/smb_acls.h
cp $BUILDDIRPATH/source3/include/ntquotas.h $SCRIPTDIR/tmp-samba-dir/source3/include/ntquotas.h
cp $BUILDDIRPATH/source3/include/local.h $SCRIPTDIR/tmp-samba-dir/source3/include/local.h
cp $BUILDDIRPATH/source3/include/safe_string.h $SCRIPTDIR/tmp-samba-dir/source3/include/safe_string.h
cp $BUILDDIRPATH/source3/include/includes.h $SCRIPTDIR/tmp-samba-dir/source3/include/includes.h
cp $BUILDDIRPATH/source3/locking/proto.h $SCRIPTDIR/tmp-samba-dir/source3/locking/proto.h
cp $BUILDDIRPATH/source3/lib/util_procid.h $SCRIPTDIR/tmp-samba-dir/source3/lib/util_procid.h
cp $BUILDDIRPATH/source3/lib/readdir_attr.h $SCRIPTDIR/tmp-samba-dir/source3/lib/readdir_attr.h
cp $BUILDDIRPATH/source3/lib/util_path.h $SCRIPTDIR/tmp-samba-dir/source3/lib/util_path.h
cp $BUILDDIRPATH/source3/lib/file_id.h $SCRIPTDIR/tmp-samba-dir/source3/lib/file_id.h
cp $BUILDDIRPATH/source3/lib/gencache.h $SCRIPTDIR/tmp-samba-dir/source3/lib/gencache.h
cp $BUILDDIRPATH/source3/smbd/proto.h $SCRIPTDIR/tmp-samba-dir/source3/smbd/proto.h
cp $BUILDDIRPATH/source3/smbd/smbd.h $SCRIPTDIR/tmp-samba-dir/source3/smbd/smbd.h
cp $BUILDDIRPATH/libcli/util/error.h $SCRIPTDIR/tmp-samba-dir/libcli/util/error.h
cp $BUILDDIRPATH/libcli/util/ntstatus.h $SCRIPTDIR/tmp-samba-dir/libcli/util/ntstatus.h
cp $BUILDDIRPATH/libcli/util/hresult.h $SCRIPTDIR/tmp-samba-dir/libcli/util/hresult.h
cp $BUILDDIRPATH/libcli/util/werror.h $SCRIPTDIR/tmp-samba-dir/libcli/util/werror.h
cp $BUILDDIRPATH/libcli/util/doserr.h $SCRIPTDIR/tmp-samba-dir/libcli/util/doserr.h
cp $BUILDDIRPATH/libcli/smb/smb2_signing.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb2_signing.h
cp $BUILDDIRPATH/libcli/smb/smb_unix_ext.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb_unix_ext.h
cp $BUILDDIRPATH/libcli/smb/smb_constants.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb_constants.h
cp $BUILDDIRPATH/libcli/smb/smb2_constants.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb2_constants.h
cp $BUILDDIRPATH/libcli/smb/smb2_lease.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb2_lease.h
cp $BUILDDIRPATH/libcli/smb/smb_common.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb_common.h
cp $BUILDDIRPATH/libcli/smb/smb_util.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb_util.h
cp $BUILDDIRPATH/libcli/smb/smb2_create_blob.h $SCRIPTDIR/tmp-samba-dir/libcli/smb/smb2_create_blob.h
cp $BUILDDIRPATH/bin/default/source3/param/param_proto.h $SCRIPTDIR/tmp-samba-dir/bin/default/source3/param/param_proto.h
cp $BUILDDIRPATH/bin/default/include/config.h $SCRIPTDIR/tmp-samba-dir/bin/default/include/config.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/smb_acl.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/smb_acl.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/misc.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/misc.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/security.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/security.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/ndr_smb_acl.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/ndr_smb_acl.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/smb2_lease_struct.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/smb2_lease_struct.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/server_id.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/server_id.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/ndr_misc.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/ndr_misc.h
cp $BUILDDIRPATH/bin/default/librpc/gen_ndr/file_id.h $SCRIPTDIR/tmp-samba-dir/bin/default/librpc/gen_ndr/file_id.h
cp $BUILDDIRPATH/bin/default/lib/param/param_local.h $SCRIPTDIR/tmp-samba-dir/bin/default/lib/param/param_local.h
cp $BUILDDIRPATH/libds/common/roles.h $SCRIPTDIR/tmp-samba-dir/libds/common/roles.h
cp $BUILDDIRPATH/librpc/ndr/libndr.h $SCRIPTDIR/tmp-samba-dir/librpc/ndr/libndr.h
cp $BUILDDIRPATH/VERSION $SCRIPTDIR/tmp-samba-dir/VERSION
cp $BUILDDIRPATH/lib/tevent/tevent.h $SCRIPTDIR/tmp-samba-dir/lib/tevent/tevent.h
cp $BUILDDIRPATH/lib/util/time.h $SCRIPTDIR/tmp-samba-dir/lib/util/time.h
cp $BUILDDIRPATH/lib/util/idtree_random.h $SCRIPTDIR/tmp-samba-dir/lib/util/idtree_random.h
cp $BUILDDIRPATH/lib/util/idtree.h $SCRIPTDIR/tmp-samba-dir/lib/util/idtree.h
cp $BUILDDIRPATH/lib/util/attr.h $SCRIPTDIR/tmp-samba-dir/lib/util/attr.h
cp $BUILDDIRPATH/lib/util/util_strlist.h $SCRIPTDIR/tmp-samba-dir/lib/util/util_strlist.h
cp $BUILDDIRPATH/lib/util/debug.h $SCRIPTDIR/tmp-samba-dir/lib/util/debug.h
cp $BUILDDIRPATH/lib/util/smb_threads_internal.h $SCRIPTDIR/tmp-samba-dir/lib/util/smb_threads_internal.h
cp $BUILDDIRPATH/lib/util/byteorder.h $SCRIPTDIR/tmp-samba-dir/lib/util/byteorder.h
cp $BUILDDIRPATH/lib/util/unix_match.h $SCRIPTDIR/tmp-samba-dir/lib/util/unix_match.h
cp $BUILDDIRPATH/lib/util/data_blob.h $SCRIPTDIR/tmp-samba-dir/lib/util/data_blob.h
cp $BUILDDIRPATH/lib/util/fault.h $SCRIPTDIR/tmp-samba-dir/lib/util/fault.h
cp $BUILDDIRPATH/lib/util/genrand.h $SCRIPTDIR/tmp-samba-dir/lib/util/genrand.h
cp $BUILDDIRPATH/lib/util/signal.h $SCRIPTDIR/tmp-samba-dir/lib/util/signal.h
cp $BUILDDIRPATH/lib/util/debug_s3.h $SCRIPTDIR/tmp-samba-dir/lib/util/debug_s3.h
cp $BUILDDIRPATH/lib/util/blocking.h $SCRIPTDIR/tmp-samba-dir/lib/util/blocking.h
cp $BUILDDIRPATH/lib/util/tsort.h $SCRIPTDIR/tmp-samba-dir/lib/util/tsort.h
cp $BUILDDIRPATH/lib/util/access.h $SCRIPTDIR/tmp-samba-dir/lib/util/access.h
cp $BUILDDIRPATH/lib/util/dlinklist.h $SCRIPTDIR/tmp-samba-dir/lib/util/dlinklist.h
cp $BUILDDIRPATH/lib/util/smb_threads.h $SCRIPTDIR/tmp-samba-dir/lib/util/smb_threads.h
cp $BUILDDIRPATH/lib/util/util.h $SCRIPTDIR/tmp-samba-dir/lib/util/util.h
cp $BUILDDIRPATH/lib/util/util_net.h $SCRIPTDIR/tmp-samba-dir/lib/util/util_net.h
cp $BUILDDIRPATH/lib/util/string_wrappers.h $SCRIPTDIR/tmp-samba-dir/lib/util/string_wrappers.h
cp $BUILDDIRPATH/lib/util/setid.h $SCRIPTDIR/tmp-samba-dir/lib/util/setid.h
cp $BUILDDIRPATH/lib/util/memory.h $SCRIPTDIR/tmp-samba-dir/lib/util/memory.h
cp $BUILDDIRPATH/lib/util/talloc_stack.h $SCRIPTDIR/tmp-samba-dir/lib/util/talloc_stack.h
cp $BUILDDIRPATH/lib/util/samba_util.h $SCRIPTDIR/tmp-samba-dir/lib/util/samba_util.h
cp $BUILDDIRPATH/lib/util/samba_modules.h $SCRIPTDIR/tmp-samba-dir/lib/util/samba_modules.h
cp $BUILDDIRPATH/lib/util/substitute.h $SCRIPTDIR/tmp-samba-dir/lib/util/substitute.h
cp $BUILDDIRPATH/lib/util/charset/charset.h $SCRIPTDIR/tmp-samba-dir/lib/util/charset/charset.h
cp $BUILDDIRPATH/lib/param/loadparm.h $SCRIPTDIR/tmp-samba-dir/lib/param/loadparm.h
cp $BUILDDIRPATH/lib/replace/replace.h $SCRIPTDIR/tmp-samba-dir/lib/replace/replace.h
cp $BUILDDIRPATH/lib/replace/system/time.h $SCRIPTDIR/tmp-samba-dir/lib/replace/system/time.h
cp $BUILDDIRPATH/lib/replace/system/locale.h $SCRIPTDIR/tmp-samba-dir/lib/replace/system/locale.h
cp $BUILDDIRPATH/lib/replace/system/wait.h $SCRIPTDIR/tmp-samba-dir/lib/replace/system/wait.h
cp $BUILDDIRPATH/lib/replace/system/network.h $SCRIPTDIR/tmp-samba-dir/lib/replace/system/network.h
cp $BUILDDIRPATH/lib/replace/system/dir.h $SCRIPTDIR/tmp-samba-dir/lib/replace/system/dir.h
cp $BUILDDIRPATH/lib/talloc/talloc.h $SCRIPTDIR/tmp-samba-dir/lib/talloc/talloc.h
cp $BUILDDIRPATH/dynconfig/dynconfig.h $SCRIPTDIR/tmp-samba-dir/dynconfig/dynconfig.h
cd $BUILDDIRPATH/
find . -delete
cd $SCRIPTDIR
mv $SCRIPTDIR/tmp-samba-dir/* $BUILDDIRPATH/
rm -rf $SCRIPTDIR/tmp-samba-dir
