#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

session=${1:-dk}
case $session in
	nimdow) /usr/local/bin/dwmblocks &
   		"$HOME"/bin/nimautostart.sh &
		exec nimdow;;
	dwm) 	picom -b --config "$HOME"/.config/picom/picom.conf
		feh --bg-fill "$HOME"/Pictures/Archlinux-digital-art-Linux-Arch-Linux-tech-1936825.jpg
		/usr/local/bin/dwmblocks &
		exec dwm;;
	dk)     /usr/local/bin/dwmblocks &
                exec dk;;
	*)      exec $1;;
esac
#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
