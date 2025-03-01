CONFIG_DIR = /home/dasith/.config
BACKUP_PATTERN = "*.hmbackup"

# Targets
.PHONY: all rebuild cleanup

all: rebuild cleanup

rebuild:
	nixos-rebuild switch --flake .#kishi

cleanup:
	find $(CONFIG_DIR) -type f -name $(BACKUP_PATTERN) -delete
