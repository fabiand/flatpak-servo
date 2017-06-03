
# http://flatpak.org/hello-world.html
# http://docs.flatpak.org/en/latest/

all: run-app

clean:
	rm -rf build/ sources/ repo/

servo-latest.tar.gz:
	curl https://download.servo.org/nightly/linux/servo-latest.tar.gz

sources:
	mkdir -p sources/files/lib sources/export
	tar xf servo-latest.tar.gz
	mv servo/ sources/files/bin
	sed -i "s#browserhtml#/app/bin/browserhtml#" sources/files/bin/resources/prefs.json
	cp blob/* sources/files/lib
	cp blob/* sources/files/bin
	cp metadata sources/

install-runtime: sources
	flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak --user install flathub runtime/org.freedesktop.Platform/x86_64/1.6 || :

repo: install-runtime
	flatpak build-export repo sources

install-app: repo
	flatpak --user remote-add --if-not-exists --no-gpg-verify local-servo-repo repo 
	flatpak --user uninstall org.servo.Servo ; flatpak --user install local-servo-repo org.servo.Servo || :

run-app: install-app
	flatpak run org.servo.Servo -w -M -g -t 4 -y 4
