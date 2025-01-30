-- AddPaletteOtherSprite.lua



-- -- config
-- 読み込むパレットの色数オフセット。0以上を指定する。
local offset = 0
-- ファイルリストを出してみる。
local ColorPalette_Directory = "D:/OneDrive/ColorPalette"

if 0 > offset then 
    print( "plz set 'offset > 0' ")
    return
end

-- ダイアログの設定
-- {{{
local dlg = Dialog()

-- レイアウト
-- {{{
dlg:canvas{ 
    -- 横幅を指定。
	width=300,
    -- 参考 : https://www.aseprite.org/api/keyevent?l=...KeyEvent.key%0D%0A%0D%20A%20string%20containing%20the%20pressed%2Freleased%20Unicode%20character.%0D%20%0D%0AKeyEvent.code%0D%0A%0D%20A%20string%20that%20identifies%20the%20pressed%2Freleased%20key%2C%20similar%20to%20the%20values%20found%0D%20in%20https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FAPI%2FUI_Events%2FKeyboard_event...&t=Code
    -- Escで閉じるように
	onkeydown=function( ev )
		if ev.code == "Escape" then
			dlg:close()
		end
	end
}
-- }}}

-- 要素ごとに自動改行
dlg:newrow{ always=true }

-- ディレクトリを読み込み中のaseprite拡張子のファイルをリストで表示。
-- {{{
for _,filename in pairs( app.fs.listFiles ( ColorPalette_Directory ) ) do
	-- 拡張子asepriteのみリスト化。
    if filename:match("%.aseprite$") then
        -- ファイル名を取得。
        local name = app.fs.fileTitle( filename )
		dlg:button{ 
			id   = name ,
			text = name ,
			onclick = function()

                -- まとめてトランザクションとして扱う。
                app.transaction(
                    "AddPaletteOtherSprite" ,
                    function()

                        -- 現在のスプライトのパレット。
                        local current_palette = app.sprite.palettes[1]

                        -- 特定のファイルを読み込んでそのパレットを読み込む
                        local load_palette = Palette{ fromFile =  app.fs.joinPath( ColorPalette_Directory , filename ) }

                        -- オフセット込みで読み込んだパレット数が0以下ならキャンセル。
                        if 0 >= #load_palette - offset then
                            print( "0 > palette num - offset" )
                            return
                        end

                        -- 初期のパレット数
                        local num = #current_palette
                        -- print( #current_palette )
                        -- パレット数を拡張
                        current_palette:resize( #current_palette + #load_palette - offset )
                        -- print( #current_palette )

                        -- 現在のパレットに追加。
                        local n = 0
                        for i = offset , #load_palette - 1 do
                            current_palette:setColor( num + n , load_palette:getColor( i ) )
                            n = n + 1
                        end

                        -- ダイアログを閉じる。
                        dlg:close()
                    end
                )
			end
		}
	end
end
-- }}}

-- }}}
-- ダイアログを表示する。
-- {{{
dlg:show{
	wait=false,
	bounds=Rectangle(),
    -- スクロールバーを表示。
	autoscrollbars=true
}

-- }}}


