curl -o addons.zip 'https://cdn.discordapp.com/attachments/1324589366668034079/1324592226072002671/addons.zip?ex=6778b624&is=677764a4&hm=73f5e45172dab6913564d6988ae6692a875be1b55720f126fb4d6d317d9c4767&'
unzip addons.zip

curl -L -o godot.zip https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_win64.exe.zip
unzip godot.zip
./Godot_v4.3-stable_win64.exe -e
