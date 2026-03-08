# *********************
# *** General Rules ***
# *********************

all:	$(FIND_OBJECT_FILES_CONTROLLERS) $(FIND_OBJECT_FILES) \
		$(LIBRARY_FILE_COW)

# *******************
# *** Clean Rules ***
# *******************

clean:
	$(RM) $(FIND_OBJECT_FILES_CONTROLLERS) $(FIND_OBJECT_FILES)
	$(RM) $(LIBRARY_FILE_COW)

distclean:
	rm -rf build