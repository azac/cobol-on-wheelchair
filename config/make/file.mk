# *****************
# *** Main File ***
# *****************

SOURCE_FILE_MAIN := $(SOURCE_FOLDER)/cow.cbl
OBJECT_FILE_MAIN := $(OBJECT_FOLDER)/cow.cbl.o

# ********************
# *** Binary Files ***
# ********************

LIBRARY_FILE_COW := $(BUILD_FOLDER_LIB)/libcow.so

# ****************
# *** Libraies ***
# ****************

LIBRARY_FILES := -lc -lm -lgmp -lcjson -ldb -llzma -lxml2 -lz -lcob