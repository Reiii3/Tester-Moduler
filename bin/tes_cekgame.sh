#!/system/bin/sh
if [ "$(basename "$0")" != "king64" ]; then
    exit 1
fi

cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Version: Fozax | Author: Henpeex\""
eval "$cmd"

# Cek apakah game berjalan
pgrep -f '${nameGame}' > /dev/null
if [ $? -eq 0 ]; then
    cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Process injecting something\""
    eval "$cmd"
    sleep 2

    sensivityOne

    # Set prioritas untuk semua proses game
    pids=$(pgrep -f '${nameGame}')
    for pid in $pids; do
        set_priorities "$pid"
        sleep 0.5
    done

    cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Successfully Inject mode\""
    eval "$cmd"

    # Tunggu sampai game ditutup
    while pgrep -f '${nameGame}' > /dev/null; do
        sleep 1
    done

    # Jika game ditutup, kirim notifikasi dan reset pengaturan
    cmd="cmd notification post -S bigtext -t \"FreeFireScript\" \"Tag\" \"Game Closed\""
    eval "$cmd"
    cmd power set-fixed-performance-mode-enabled false
fi