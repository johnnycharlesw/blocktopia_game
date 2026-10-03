mp = core.get_modpath("stones")
dofile(mp .. '/stones.lua')
dofile(mp .. '/ores.lua')
dofile(mp .. '/blocks.lua')

core.register_alias("default:checker", "stones:stone")
core.register_alias("default:stone", "stones:stone")
core.register_alias("default:cobblestone", "stones:cobblestone")