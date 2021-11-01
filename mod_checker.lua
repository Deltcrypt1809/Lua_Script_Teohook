Mod_uid = 0 -- 32036726 kailyx
-- 8651339 lunapurl
-- 22353525 ubidev
-- 682 solorien
-- 25 hamumu
-- 2 seth
-- 36310143 pangloss
-- 16966321 fournos
-- 15006163 bleulabel
-- 536707 misthios
-- 73346 aimster
-- 553625 jenuine
-- 25374 anulot
-- 538522 akiko
-- 41538029 kodrex
-- 24969470 qadevone
-- 24233063 nplus1
-- 25181947 thepsyborg
-- 22242821 vectorcat

pkt = string.format([[action|dialog_return
dialog_name|friends_message
friendID|%d|
buttonClicked|send

text|
]], mod_uid)

sendPacket(false, pkt, 2)