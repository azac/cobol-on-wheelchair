# **********************
# *** Compile libcow ***
# **********************

$(LIBRARY_FILE_COW): $(FIND_OBJECT_FILES_CONTROLLERS) $(FIND_OBJECT_FILES)
	@mkdir -p $(dir $@)
	$(LD) $(LDFLAGS) -o $@ $^ -Q -Wl,-rpath="$(LIBRARY_FOLDER):$(LIBRARY_FOLDER_GNUCOBOL)"