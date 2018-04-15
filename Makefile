ifneq (${KERNELRELEASE},)
	obj-m := usb.o
else
	KDIR ?= /lib/modules/$(shell uname -r)/build
	PWD := $(shell pwd)
	BUILD_DIR ?= $(PWD)/build
	BUILD_DIR_MAKEFILE ?= $(PWD)/build/Makefile

default: $(BUILD_DIR_MAKEFILE)
	make -C $(KDIR) M=$(BUILD_DIR) src=$(PWD) modules
$(BUILD_DIR): 
	mkdir -p "$@"

$(BUILD_DIR_MAKEFILE): $(BUILD_DIR)
	touch "$@"

clean:
	make -C $(KDIR) M=$(BUILD_DIR) src=$(PWD) clean
#all:
#	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
#install:
#	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
#%:
#	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) $@
endif
