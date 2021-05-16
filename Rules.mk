include $(HOME)/Config.mk

%.S.o: %.S
	@$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $(OBJ_DIR)/$@
%.c.o: %.c
	@$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $(OBJ_DIR)/$@
%.cpp.o: %.cpp
	@$(CXX) $(CCFLAGS) -I$(INC_DIR) -c $< -o $(OBJ_DIR)/$@

$(TARGET).img: $(OBJS)
	@echo "  LD $(TARGET).elf"
	@$(LD) -o $(BUILD_DIR)/$(TARGET).elf -Map $(BUILD_DIR)/$(TARGET).map $(patsubst %.o,$(OBJ_DIR)/%.o,$(OBJS)) $(LDFLAGS) 
	@echo "  COPY  $(TARGET).img"
	@$(CPY) $(BUILD_DIR)/$(TARGET).elf -O binary $(BUILD_DIR)/$(TARGET).img
	@echo "  DUMP  $(TARGET).disasm"
	@$(DMP) -l -S -D $(BUILD_DIR)/$(TARGET).elf > $(BUILD_DIR)/$(TARGET).disasm