# ----------------------------
# Program Options
# This makefile was partially generated by TI-Planet's Project Builder
# ----------------------------

NAME         = AACALC # It will be at the beginning
ICON         = icon.png
DESCRIPTION  = "Calculator"
COMPRESSED   = YES
ARCHIVED     = YES

# ----------------------------
# Compile Options
# ----------------------------

CFLAGS   = -Oz -W -Wall -Wextra -Wwrite-strings
CXXFLAGS = -Oz -W -Wall -Wextra -Wwrite-strings

# ----------------------------

include $(shell cedev-config --makefile)