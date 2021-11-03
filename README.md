# YakData R 4.1.1 "on the Rocker"
##  Build R 4.1.1 with verse, tidyverse and the RStudio IDE (open source) in 3 progressive Docker containers.

<img src="./R_logo.png" alt="R_Logo" style="zoom:10%;" />

 
  - [🎶 Features](#-features)
  - [🧰 Install and setup 🔒 SSL/TLS](#-install-and-setup--ssltls)
  - [🔐 LICENSE](#-license)
  - [⭐ Inspiration](#-inspiration)
  - [📫 Issues](#-issues)
  - [📘 Docs](#-docs)
  - [💼 Alternatives](#-alternatives)
  - [🧑‍💻 Discussion](#-discussion)
  
## 🎶 Features

* This is based on the Rocker project. It has been modified for use in [YakData/SmartManager-for-ShinyProxy](https://github.com/Stephen-McDaniel/SmartManager-for-ShinyProxy)

The structure of the Dockerfiles in rocker-versioned is:

r411
    rstudio
        tidyverse
            verse
                rstudiofinal

Here, it has been simplified to:

r-4.1.1
    verse-r-4.1.1
        rstudio-verse-r-4.1.1

## 🧰 Install and setup 🔒 SSL/TLS

Logon to your server


If it doesn't exist, create /yakdata
```bash
sudo mkdir /yakdata
sudo chown ubuntu:ubuntu /yakdata
mkdir /yakdata/apps
```

Upload /yakdata/apps from this repository to /yakdata/

```bash
# from local to server
dir_local="/path/to/downloaded/and/unzippped/repo/yakdata/apps/"
dir_remote=/yakdata/apps
keyfile='/path/to/your/pem/my.pem'
host=my.host.com

cd "$dir_local"

rsync --progress -h -v -r -P -t -z --no-o --no-g \
      -e "ssh -i $keyfile" \
      $dir_local ubuntu@$host:$dir_remote --delete
```

Login and change folder permissions.
```bash
ssh -i "$keyfile" "ubuntu@$host"

cd /yakdata/apps/R/4.1.1

chmod +x /yakdata/apps/R/4.1.1/scripts/*.sh
```

Run the Docker Compose builds. Total time to install may take 10 minutes to 2 hours, depending on your host system performance.

IMPORTANT- ensure that you have your terminal session set to send an ASCII code when idle or similar setting. On the Mac with iTerm2, this is under Session -> Edit Session -> pick the session from the list -> Session -> "When idle, send ASCII code...". Otherwise, the builds may time out and fail.

```bash
cd /yakdata/apps/R/4.1.1

(
docker-compose build r-4.1.1
) 2>&1 |& tee /yakdata/apps/logs-docker-compose-builds/R-r-4.1.1.log

(
docker-compose build verse-r-4.1.1
) 2>&1 |& tee /yakdata/apps/logs-docker-compose-builds/R-verse-r-4.1.1.log 

(
docker-compose build rstudio-verse-r-4.1.1
) 2>&1 |& tee /yakdata/apps/logs-docker-compose-builds/R-rstudio-verse-r-4.1.1.log 
```

NOTE
By default, the R packages will install from the RSPM repository, with a date of 2021-09-22

```bash
CRAN=https://packagemanager.rstudio.com/cran/2021-09-22+MTo1MTg0MzM5O0Q4MjI2M0Y
```

Command output will echo to the session where you started the installation. If you like, you can connect with a second SSH session and watch the logs at /yakdata/apps/logs-docker-compose-builds

## 🔐 LICENSE

This repository is licensed under [GPLv2](https://opensource.org/licenses/gpl-2.0.php).

## 📫 Issues

Please share issues here in this repository [Issues](https://github.com/yakdata/R-on-the-rocker/issues).

## 📘 Docs

Based on: https://github.com/rocker-org/rocker-versioned

## 💼 Alternatives

Do it yourself. Some people just like to do it all!

Use rocker-versioned directly.

## 🧑‍💻 Discussion

Head over to [The YakData Community](https://meta.yakdata.com). You can login to comment with your Github account, a Google account or your email and a password.

