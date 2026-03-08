# ************************
# *** General Generate ***
# ************************

$(OBJECT_FOLDER)/%.cbl.o: $(SOURCE_FOLDER)/%.cbl
	@mkdir -p $(dir $@)
	$(COB) $(COBFLAGS) -O3 -c -o $@ $<

# ****************************
# *** Controllers Generate ***
# ****************************

$(OBJECT_FOLDER)/%.cbl.o: $(SOURCE_FOLDER_CONTROLLERS)/%.cbl
	@mkdir -p $(dir $@)
	$(COB) $(COBFLAGS) -Os -c -o $@ $<