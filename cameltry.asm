.include "src/def.asm"
.include "src/ram.asm"
.include "src/macros.asm"

.include "nsf-header.asm"

.base $8000
.include "src/prg-1.asm"

.pad $bf00, $ff
.include "src/nsf-home.asm"

.pad $c000, $ff
.incbin "src/dmc-fds.bin"