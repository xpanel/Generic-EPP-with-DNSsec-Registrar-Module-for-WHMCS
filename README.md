# Generic EPP with DNSsec Registrar Module for WHMCS
Generic EPP with DNSsec Registry-Registrar Module for WHMCS >= 7.7.1

	# Generic EPP module for WHMCS which provide full functionality coverage for domains management and based on communication with Registry through Extensible Provisioning Protocol (EPP).
	# EPP: RFC 5730, 5731, 5732, 5733, 5734, 5910
	# this module it is working with https://www.rrpproxy.net/ (https://www.rrpproxy.net/API/EPP), http://www.udr.hk.com/registry, also you can create your own Registry using Open Source EPP Server https://sourceforge.net/projects/epp-server/


## Installation steps
	# Upload via FTP the 'genericepp' directory to <whmcs_root>/modules/registrars/
	# Set write permissions for log file <whmcs_root>/modules/registrars/genericepp/log/genericepp.log


## Generate .PEM certificate 
	# create .pfx file 
	# openssl pkcs12 -export -out certificate.pfx -inkey www.yourdomain.com.key -in yourdomain.com.crt -certfile CA_bundle.crt 
	openssl pkcs12 -export -out certificate.pfx -inkey /etc/pki/tls/private/www.yourdomain.com.key -in /etc/pki/tls/certs/yourdomain.com.crt -certfile /etc/pki/tls/certs/gd_bundle.crt 

	# create PEM file 

	# include PassPhrase 
	openssl pkcs12 -in certificate.pfx -out certificate.cer -nodes 

	# or 
	# without PassPhrase 
	openssl pkcs12 -in certificate.pfx -out certificate.cer 


## Upload certificates
	# Copy certificate.cer to <whmcs_root>/modules/registrars/genericepp/local_cert/certificate.cer
	# Copy www.yourdomain.com.key to <whmcs_root>/modules/registrars/genericepp/local_pk/www.yourdomain.com.key
	# Copy a certificate authority file to <whmcs_root>/modules/registrars/genericepp/cafile/


## or you may use https://letsencrypt.org/
	dnf install git net-tools
	git clone https://github.com/certbot/certbot.git
	cd certbot/
	./letsencrypt-auto --help
	systemctl stop httpd
	./letsencrypt-auto certonly --standalone


## Test connection with the server
	# please make sure port 700 is not firewalled:
	telnet epp-ote.nic.xy 700 
	openssl s_client -showcerts -connect epp-ote.nic.xy:700 

	# command line for acceptable client certificate CA names 
	openssl s_client -showcerts -connect epp-ote.nic.xy:700 -CAfile gd_bundle.crt

	# command line to verify your own Certificate 
	openssl s_client -showcerts -connect epp-ote.nic.xy:700 -CAfile CA_bundle.crt -cert yourdomain.com.crt -key yourdomain.com.key


## Add your whois server to the list, if not exist
	# edit file <whmcs_root>/resources/domains/dist.whois.json
	# check Not available text response on the whois server (No match for)
	,
    {
        "extensions": ".com.xy,.org.xy",
        "uri": "socket://whois.com.xy",
        "available": "No match for"
    }


## Configure Generic EPP module in WHMCS
	# Login to WHMCS admin panel.
	# Go to Setup > Products/Service > Domain registrars
	# Activate Generic EPP module
	# Configure module by providing EPP Server access credentials


## Start using module
	# Login to WHMCS admin panel.
	# Go to Setup > Products/Service > Domain pricing
	# Create ".yourtld" TLD and selectg "Genericepp" module in "Auto Registration" field
	# Define your pricing for different registration/renewal terms
