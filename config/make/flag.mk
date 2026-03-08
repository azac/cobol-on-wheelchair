# **********************
# *** Compiler Flags ***
# **********************

COBFLAGS := -Wall -Wextra -Werror -fstatic-call -std=ibm-strict -I$(HEADER_FOLDER)

# ********************
# *** Linker Flags ***
# ********************

LDFLAGS := -L$(LIBRARY_FOLDER) -L$(LIBRARY_FODLER_GNUCOBOL) -b