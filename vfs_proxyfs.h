// Copyright (c) 2015-2021, NVIDIA CORPORATION.
// SPDX-License-Identifier: Apache-2.0

#ifndef __VFS_PROXYFS_H__
#define __VFS_PROXYFS_H__

#include <proxyfs.h>

typedef struct {
	mount_handle_t *mnt_handle;
	char           *volume;
	char           *cwd;
	uint64_t       cwd_inum;
	uint64_t       open_count;
	bool           readonly;
} fs_ctx_t;

typedef struct telldir_info_s {
	char	name[NAME_MAX];
	long	offset;
	bool	use_name;
} telldir_info_t;

typedef struct file_handle_s {
	uint64_t        inum;
	off_t           offset;
	uint64_t        flags;
	uint64_t        mode;
	struct dirent   dir_ent;
	bool            use_name;         // Use last returned name as the marker for readdir otherwise offset will be used.
	char           *prev_readdir_name;
	telldir_info_t  telldir_info[2];  // 1: Contains the last telldir info and 0: Contains one before that.
} file_handle_t;

/* fs_ctx_t Operations */
#define MOUNT_HANDLE(handle) (((fs_ctx_t *)handle->data)->mnt_handle)
#define CWD(handle) (((fs_ctx_t *)handle->data)->cwd)
#define CWD_INUM(handle) (((fs_ctx_t *)handle->data)->cwd_inum)

#endif // __VFS_PROXYFS_H__
