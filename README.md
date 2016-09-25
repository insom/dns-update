# dns-update
Ruby Dynamic DNS Updater

To install:

	gem install dns-update

To use:

	Usage: dns-update [options]
		-u, --url URL                    JSON IP URL
		-e, --key-name KEY-NAME          Name of the TSIG key
		-k, --key KEY                    Base64 encoded TSIG key
		-z, --zone ZONE                  DNS Zone to update
		-r, --record RECORD              DNS Record to update
		-n, --nameserver NAMESERVER      Nameserver to update
		-t, --ttl TTL                    TTL of newly updated record

To set up your zone file for dynamic updates, you should generate a key file
with `tsig-keygen`:

	$ tsig-keygen
	key "tsig-key" {
		algorithm hmac-sha256;
		secret "ww4qyRqNH7CVk8U4m0Y0Rjin5G35YJgMv93sjTcRFo4=";
	};

Save the output to a safe place, copy and paste it into your `named.conf`, and
add an `update-policy` to your zone config:

	$ cat named.conf
	key "tsig-key" {
		algorithm hmac-sha256;
		secret "ww4qyRqNH7CVk8U4m0Y0Rjin5G35YJgMv93sjTcRFo4=";
	};
	zone "insomnike.tk" {
		type master;
		file "/etc/bind/db.insomnike.tk";
		update-policy {
			grant tsig-key zonesub ANY;
		};
		notify yes;
	};
	...

Now you can call `dns-update` with your authentication details. It will get
your external IP from jsonip.com and then update your DNS records:

	dns-update -e tsig-key -z insomnike.tk \
		-n ns.insomnike.tk -r house.insomnike.tk \
		-k ww4qyRqNH7CVk8U4m0Y0Rjin5G35YJgMv93sjTcRFo4=
