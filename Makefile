HOME := .
include Config.mk

all: clean
	@echo "  CCFLAGS = $(CCFLAGS)"
	@echo "  LDFLAGS = $(LDFLAGS)"
	@mkdir -p $(OBJ_DIR) && cd $(OBJ_DIR) && mkdir -p $(DIRS)
	@$(MAKE) -C $(SRC_DIR)

clean:
	@echo cleaning up ...
	@rm -vrf $(BUILD_DIR) > /dev/null
