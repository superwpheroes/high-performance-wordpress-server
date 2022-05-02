# High-Performance-Production-Server (SpeedWp.io)

### Why

Performance is already important for modern Wordpress sites as users don't want to wait for loading. 

However, Google Core Web Vitals update this year will make performance more important page ranking will be impacted significantly.
This is measured using tools such as Pagespeed.

### What Can I do about this for my Wordpress site?


1. Get faster hosting.
2. Get a caching plugin.
3. Get away from Wordpress page builders, and use Gutenberg with a light theme.

## Let's get started.

---

## 1: Cloud Hosting

## Setup a VM Instance with Google Cloud

You can use any cloud (I've used Oracle, AWS, Azure), but Google seems to be the most cost-effective option.

We will use the (**f1-micro**) which costs nothing... for ever! . You can upgrade this to a better CPU if needed later.

- choose location
- open ports: HTTP, HTTPS
- Boot disk: Ubuntu 20.04 LTS
- Networking apply tag: `superwp` ,
- use the installer content as startup script to install the instance :

## Or sudo into instance

```jsx
wget https://raw.githubusercontent.com/Softicious/high-performance-production-server/main/installer
chmod +x installer
sudo ./installer
Document root will show Hello SPeedy
```

## Add Networking Rules
- Networking>VPC Networks>Firewall
- add `7080` firewall rule with IP range: `0.0.0.0/0`
- add `3306`, `33060` firewall rule with IP range: `10.0.0.0/0`

At this point, go and make a coffee. It takes some time for your new VM to process the startup script. You will know its ready when you can successfully do the following command in SSH:

- SSH connect, from the Google cloud portal next to your VM, to create password for OpenLitespeed dashboard:

```bash
sudo /usr/local/lsws/admin/misc/admpass.sh (no need when using installer)
```

- go to dashboard:

```bash
http://102.021.03.2:7080
```

- Add ip address or domain and do Soft Restart

```jsx
>Listeners>Default>Virtual Host Mappings>Domains
```

- Copy the Primary Internal IP `10.128.0.2`

## Setup a separate MySQL database

We will then use a separate managed MySQL database (**db.t2.micro**)

- Machine type: Shared core
- Same location as VM
- Add root password
- Storage: 10GB
- Connections: Private IP, `default` automatic IP range.
- Connections: no Public
- Connect to add IP of VM: `10.128.0.2` (or your specific IP)
- Click on instance to get IP of database
- Create database `wordpress` (or any other cms)

Now you can login to your website again, using the IP of your instance, and enter the details:
```
Database name: wordpress
Username: Root
Password: (password created with MySQSL)
Database Host: Internal IP of MySQL
Table Prefix: wp_ // speedwp
```
Your Production server should now be ready!


