
#
# CPU sub-Makefile
#
# Copyright (C) 2020-2025 Gabriele Galeotti
#
# This work is licensed under the terms of the MIT License.
# Please consult the LICENSE.txt file located in the top-level directory.
#

ifeq ($(KERNEL_PARENT_PATH),)
$(error Error: invalid KERNEL_PARENT_PATH)
endif
ifeq ($(LIBRARY_DIRECTORY),)
$(error Error: invalid LIBRARY_DIRECTORY)
endif
ifeq ($(OBJECT_DIRECTORY),)
$(error Error: invalid OBJECT_DIRECTORY)
endif

include $(KERNEL_PARENT_PATH)/Makefile.os.in
include $(KERNEL_PARENT_PATH)/Makefile.ut.in
include $(KERNEL_PARENT_PATH)/Makefile.fn.in

# shorthands
LIB_DIRECTORY     := $(KERNEL_PARENT_PATH)/$(LIBRARY_DIRECTORY)
OBJ_DIRECTORY     := $(KERNEL_PARENT_PATH)/$(OBJECT_DIRECTORY)
DEP_DIRECTORY     := $(OBJ_DIRECTORY)
ifeq ($(OSTYPE),cmd)
LIB_DIRECTORY_CMD := $(subst /,\,$(LIB_DIRECTORY))
OBJ_DIRECTORY_CMD := $(subst /,\,$(OBJ_DIRECTORY))
DEP_DIRECTORY_CMD := $(OBJ_DIRECTORY_CMD)
endif

LIBRARY_NAME := cpu

OBJECTS :=
ifeq ($(CPU_MODEL),R3000)
OBJECTS += $(OBJ_DIRECTORY)/cache.o
endif
ifneq ($(USE_LIBGCC),Y)
ifeq ($(or                                        \
  $(if $(findstring R3000,     $(CPU_MODEL)),Y,), \
  $(if $(findstring MIPS32-24K,$(CPU_MODEL)),Y,), \
  $(if $(findstring MIPS64-20K,$(CPU_MODEL)),Y,)  \
  ),Y)
OBJECTS += $(OBJ_DIRECTORY)/libgcc.o
endif
endif

.PHONY: all
all: $(OBJ_DIRECTORY)/lib$(LIBRARY_NAME).a

.PHONY: configure
configure:
	@$(CREATESYMLINK) $(KERNEL_PARENT_PATH)/$(GNATADC_FILENAME) $(GNATADC_FILENAME)

.PHONY: clean
clean:
	$(RM) $(CLEAN_OBJECTS_COMMON)

.PHONY: distclean
distclean: clean
	$(RM) $(DISTCLEAN_OBJECTS_COMMON)

include $(KERNEL_PARENT_PATH)/Makefile.lb.in

