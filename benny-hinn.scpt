set dontplay to 0
set done to 0
tell application "Keynote"
  start from slide 1 of front document
end tell

set volume output volume 80

repeat while done is 0
  tell application "Keynote"

    -- Start a song
    if get slide number of current slide of front document is 41 and dontplay is 0 then
      set dontplay to 1
      tell application "VLC"
        OpenURL "file:///Users/caleb.thompson/Downloads/MusicaDeCirco-BennyHill.mp3"
        play
      end tell
    end if

    -- Reset dontplay on the next slide
    if get slide number of current slide of front document is 88 then
      set done to 1
      tell application "VLC" to play
    end if

    -- Repeat the schema for each slide you want to start a new song :)
  end tell
end repeat

tell application "VLC" to quit
