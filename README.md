This script is designed for quick deployment of basic services, allowing for the organization of a workspace in small companies.
1) The first option allows you to set everything up on a single server, including backups, monitoring, a file server (Samba), and OpenVPN (acting as a gateway);
2) The second option allows you to set up a file server and a gateway on the current server where the script is launched, while the monitoring server will be deployed as a standalone instance but will be connected to the gateway via OpenVPN at the end of the installation.
3) The third option allows you to deploy the file server and monitoring server on separate machines. OpenVPN will also be installed on the server from which the script is launched.
4) The fourth option is in BETA testing. It can help you create a virtual machine in Timeweb Cloud if you have an account there and a configured CLI token.
5) The fifth option is intended for generating a VPN configuration for a user or another server.
Important! All settings, including passwords, are displayed in the command line during installation. Once everything is installed and configured, replace the personal data for your security.

