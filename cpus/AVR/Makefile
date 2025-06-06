
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

ifneq ($(USE_LIBGCC),Y)
LIB1ASMSRC       := lib1funcs.S
LIBGCC_FUNCTIONS := adddi3_s8 cmpdi2 cmpdi2_s8 ashrdi3 negsi2 subdi3 mulsidi3   \
                    umulsidi3 umulhisi3 muldi3_6 divmodsi4 udivmodsi4 divmodhi4 \
                    udivmodhi4 negdi2 divdi3 moddi3 udivdi3 udivmod64           \
                    prologue epilogue
LIBGCC_SOURCES   := $(foreach f,$(LIBGCC_FUNCTIONS),L_$(f).S)
OBJECTS          += $(foreach f,$(LIBGCC_FUNCTIONS),$(OBJ_DIRECTORY)/L_$(f).o)
$(LIBGCC_SOURCES): %.S : $(LIB1ASMSRC)
	$(call brief-command, \
        $(CPP) -o $@ -x assembler-with-cpp -P -CC -D$* $(LIB1ASMSRC) \
        ,[CPP],$@)
else
LIBGCC_SOURCES :=
endif

.PHONY: all
all: $(OBJ_DIRECTORY)/lib$(LIBRARY_NAME).a

.PHONY: configure
configure: $(LIBGCC_SOURCES)
	@$(CREATESYMLINK) $(KERNEL_PARENT_PATH)/$(GNATADC_FILENAME) $(GNATADC_FILENAME)

.PHONY: clean
clean:
	$(RM) $(CLEAN_OBJECTS_COMMON)

.PHONY: distclean
distclean: clean
	$(RM) $(DISTCLEAN_OBJECTS_COMMON)
ifneq ($(USE_LIBGCC),Y)
	$(RM) $(LIBGCC_SOURCES)
endif

include $(KERNEL_PARENT_PATH)/Makefile.lb.in

