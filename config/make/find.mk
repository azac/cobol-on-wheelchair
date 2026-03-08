# *************************
# *** Find Source Files ***
# *************************

FIND_SOURCE_FILES             := $(shell find $(SOURCE_FOLDER) -type f -name '*.cbl')
FIND_SOURCE_FILES_CONTROLLERS := $(shell find $(SOURCE_FOLDER_CONTROLLERS) -type f -name '*.cbl')

# *************************
# *** Find Object Files ***
# *************************

FIND_OBJECT_FILES             := $(patsubst $(SOURCE_FOLDER)/%.cbl, $(OBJECT_FOLDER)/%.cbl.o, $(FIND_SOURCE_FILES))
FIND_OBJECT_FILES_CONTROLLERS := $(patsubst $(SOURCE_FOLDER_CONTROLLERS)/%.cbl, $(OBJECT_FOLDER)/%.cbl.o, $(FIND_SOURCE_FILES_CONTROLLERS))