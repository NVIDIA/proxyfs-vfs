CC            = gcc
CFLAGS        = -g -Os -fPIC
INSTALLCMD    = /usr/bin/install -c
LDFLAGS       = -shared
JRPCCLIENTDIR = ../jrpcclient

PROXYFSDOTSO  = $(JRPCCLIENTDIR)/libproxyfs.so

ifndef SAMBA_PATH
SAMBA_PATH := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/samba
endif

include $(SAMBA_PATH)/VERSION
FLAGS = $(CFLAGS) -I$(JRPCCLIENTDIR) -I$(SAMBA_PATH) -I$(SAMBA_PATH)/source3 -I$(SAMBA_PATH)/source3/include -I$(SAMBA_PATH)/lib/talloc -I$(SAMBA_PATH)/lib/tevent -I$(SAMBA_PATH)/lib/replace -I$(SAMBA_PATH)/bin/default -I$(SAMBA_PATH)/bin/default/include

DEPS = vfs_proxyfs.h

VFS_CENTOS_LIBDIR ?= /usr/lib64/samba/vfs
VFS_LIBDIR ?= /usr/lib/x86_64-linux-gnu/samba/vfs

all: proxyfs.so

%.o: %.c $(DEPS)

	@echo "Compiling $<"
	$(CC) -DSAMBA_VERSION_MAJOR=$(SAMBA_VERSION_MAJOR) -DSAMBA_VERSION_MINOR=$(SAMBA_VERSION_MINOR) $(FLAGS) -c $<

proxyfs.so: vfs_proxyfs.o
	@echo "Linking $@"
	$(CC)  -o $@ $< $(LDFLAGS) $(PROXYFSDOTSO)

install:
	$(INSTALLCMD) -d $(VFS_LIBDIR)
	$(INSTALLCMD) -m 755 proxyfs.so $(VFS_LIBDIR)

installcentos:
	$(INSTALLCMD) -d $(VFS_CENTOS_LIBDIR)
	$(INSTALLCMD) -m 755 proxyfs.so $(VFS_CENTOS_LIBDIR)

clean:
	rm -f vfs_proxyfs.o proxyfs.so
