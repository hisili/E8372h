# Created by y00184236, 2013-04-18

#*************************************************************************
# definition 
#*************************************************************************
PCLINT_SYSTEM_INC_FILE		?=
PCLINT_INC_VAR				?= 
PCLINT_INC_FILE				?= 
PCLINT_SRC_FILE				?=
PCLINT_CC_OPTION			?=

PCLINT_TOOL_PATH	:=$(BALONG_TOPDIR)/build/tools/pc_lint/lint
PCLINT_TOOL			:=$(BALONG_TOPDIR)/build/tools/pc_lint/lint/lint-nt.exe
PCLINT_OBJ_PATH		:= $(OBB_PRODUCT_DELIVERY_DIR)/obj/$(OBC_LOCAL_MOUDLE_NAME)
PCLINT_LOG			:=$(OBB_PRODUCT_DELIVERY_DIR)/log/pclint_$(OBC_LOCAL_MOUDLE_NAME)_$(OBB_PRODUCT_NAME).log

#*************************************************************************
# rules
#*************************************************************************
.PHONY: do_pclint
do_pclint:
	@echo do $@
	@mkdir -p $(PCLINT_OBJ_PATH) $(OBB_PRODUCT_DELIVERY_DIR)/log/
	@sed -e 's,BALONG_TOPDIR,$(BALONG_TOPDIR),g' $(PCLINT_SYSTEM_INC_FILE) > $(PCLINT_OBJ_PATH)/pclint_system_inc.lnt

	@echo $(sort $(PCLINT_INC_VAR))  $(filter -D%, $(PCLINT_CC_OPTION)) > $(PCLINT_OBJ_PATH)/pclint_inc.lnt

ifneq ($(PCLINT_INC_FILE),)
	@sed -e 's,BALONG_TOPDIR,$(BALONG_TOPDIR),g' -e 's,OBB_PRODUCT_NAME,$(OBB_PRODUCT_NAME),g' -e 's,CFG_PLATFORM,$(CFG_PLATFORM),g' $(PCLINT_INC_FILE) >> $(PCLINT_OBJ_PATH)/pclint_inc.lnt
endif
	@sed -e 's,BALONG_TOPDIR,$(BALONG_TOPDIR),g' -e 's,CFG_PLATFORM,$(CFG_PLATFORM),g' $(PCLINT_SRC_FILE) > $(PCLINT_OBJ_PATH)/pclint_src.lnt
ifneq ($(PCLINT_SRC_PLATFORM_FILE),)
	@sed -e 's,BALONG_TOPDIR,$(BALONG_TOPDIR),g' -e 's,CFG_PLATFORM,$(CFG_PLATFORM),g' $(PCLINT_SRC_PLATFORM_FILE) >> $(PCLINT_OBJ_PATH)/pclint_src.lnt
endif
	@wine $(PCLINT_TOOL) -u  $(PCLINT_OBJ_PATH)/pclint_system_inc.lnt -w2 $(PCLINT_OBJ_PATH)/pclint_inc.lnt  $(PCLINT_OBJ_PATH)/pclint_src.lnt > $(PCLINT_LOG)

#***********************************************************
# Clean up 
#***********************************************************
.PHONY: do_clean
do_clean:
	$(Q)-rm -rf $(PCLINT_OBJ_PATH)/pclint_system_inc.lnt  $(PCLINT_OBJ_PATH)/pclint_inc.lnt  $(PCLINT_OBJ_PATH)/pclint_src.lnt $(PCLINT_LOG)
