Museum1F_h: ; 0x5c0eb to 0x5c0f7 (12 bytes) (id=52)
	db MUSEUM ; tileset
	db MUSEUM_1F_HEIGHT, MUSEUM_1F_WIDTH ; dimensions (y, x)
	dw Museum1FBlocks, Museum1FTextPointers, Museum1FScript ; blocks, texts, scripts
	db $00 ; connections
	dw Museum1FObject ; objects
