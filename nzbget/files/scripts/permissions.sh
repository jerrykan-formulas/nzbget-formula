#!/bin/sh

# post-processing script for fixing permissions

################################################################################
### NZBGET POST-PROCESSING SCRIPT                                            ###

# Change file permission.

################################################################################
### OPTIONS                                                                  ###

# Permissions (rwxXst) for each user type
user=rwX
group=rwX
other=rX

### NZBGET POST-PROCESSING SCRIPT                                            ###
################################################################################

# recursively set perms files

chmod -R u=${NZBPO_USER:-$user},g=${NZBPO_GROUP:-$group},o=${NZBPO_OTHER:-$other} "$NZBPP_DIRECTORY"

exit 93
