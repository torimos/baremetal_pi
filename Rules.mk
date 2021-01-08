include $(HOME)/Config.mk

%.S.o: %.S
	@$(CC) $(CFLAGS) -c $< -o $(OBJ_DIR)/$@
%.c.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $(OBJ_DIR)/$@
%.cpp.o: %.cpp
	@$(CXX) $(CCFLAGS) -c $< -o $(OBJ_DIR)/$@

$(TARGET).img: $(OBJS)
	@echo "  LD $(TARGET).elf"
	@$(LD) $(LDFLAGS) -o $(BUILD_DIR)/$(TARGET).elf -Map $(BUILD_DIR)/$(TARGET).map \
		-T $(LINKER_DIR)/$(LINKERFILE) $(patsubst %.o,$(OBJ_DIR)/%.o,$(OBJS)) \
		--start-group $(LIBS) $(EXTRALIBS) --end-group
	@echo "  COPY  $(TARGET).img"
	@$(CPY) $(BUILD_DIR)/$(TARGET).elf -O binary $(BUILD_DIR)/$(TARGET).img
	@echo "  DUMP  $(TARGET).disasm"
	@$(DMP) -l -S -D $(BUILD_DIR)/$(TARGET).elf > $(BUILD_DIR)/$(TARGET).disasm