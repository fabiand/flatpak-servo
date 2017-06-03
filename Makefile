
all: run-app

sources:
	mkdir files export
	curl https://download.servo.org/nightly/linux/servo-latest.tar.gz | tar xf -
	mv servo/ files/bin

add-remote:
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

install-runtime: add-remote
	flatpak install flathub runtime/org.freedesktop.Platform/x86_64/1.6

build-app: install-runtime
	flatpak build-export repo servo-flatpak

add-repo: build-app
	flatpak --user remote-add --no-gpg-verify servo-flatpak-repo repo

install-app: add-repo
	flatpak --user uninstall org.servo.servo.nightly && flatpak --user install servo-flatpak-repo org.servo.servo.nightly

run-app: install-app
	flatpak run org.servo.servo.nightly -w -M -g -t 4 -y 4 https://wikipedia.org
