AARCH	 ?= 32
MODEL	 ?= 1
FLOAT_ABI ?= hard

STDLIB_SUPPORT ?= 0
GC_SECTIONS ?= 0

SRC_DIR = $(HOME)/src
INC_DIR = $(HOME)/include
LINKER_DIR = $(HOME)/linker
BUILD_DIR = $(HOME)/build
OBJ_DIR = $(BUILD_DIR)/obj

ifeq ($(strip $(AARCH)),32)
	PREFIX	 ?= arm-none-eabi-
	ifeq ($(strip $(MODEL)),1)
		ARCH = -mcpu=arm1176jzf-s -marm -mfpu=vfp -mfloat-abi=$(FLOAT_ABI) -DRPI1 -Ofast
		TARGET = kernel
		LINKERFILE = rpi32.ld
	else
		$(error MODEL must be set to 0, 1, 2, 3 or 4)
	endif
else ifeq ($(strip $(AARCH)),64)
	PREFIX ?= aarch64-none-elf-
	TARGET = kernel8
else
	$(error AARCH must be set to 32 or 64)
endif

CC	 = $(PREFIX)gcc
CXX	 = $(PREFIX)g++
LD	 = $(PREFIX)ld
CPY	 = $(PREFIX)objcopy
DMP	 = $(PREFIX)objdump
NM	 = $(PREFIX)nm
HDMP = hexdump

ifeq ($(strip $(STDLIB_SUPPORT)),0)
	LIBGCC	  = "$(shell $(CXX) $(ARCH) -print-file-name=libgcc.a)"
	LIBC	  = "$(shell $(CXX) $(ARCH) -print-file-name=libc.a)"
	ifneq ($(strip $(LIBGCC)),"libgcc.a")
		EXTRALIBS += $(LIBGCC)
	endif
	ifneq ($(strip $(LIBC)),"libc.a")
		EXTRALIBS += $(LIBC)
	endif
	CCFLAGS += -fno-exceptions -fno-rtti -nostdinc++
endif

ifeq ($(strip $(GC_SECTIONS)),1)
	CFLAGS	+= -ffunction-sections -fdata-sections
	LDFLAGS	+= --gc-sections
endif

CFLAGS += -Wall -fsigned-char -nostartfiles -ffreestanding -g $(ARCH) -I$(INC_DIR)
CCFLAGS += $(CFLAGS) -std=c++14 -Wno-aligned-new

OBJECTS = $(patsubst $(SRC_DIR)/%, %.o, $(shell find $(SRC_DIR)/ -type f -name '*.*'))
DIRS = $(filter-out ./,$(sort $(dir $(OBJECTS))))

