# Manual deployment GeoCitizen


### requirements 

- [Ubuntu Server 20.04](https://losst.ru/ustanovka-ubuntu-20-04)
- [CentOS 7.9](https://linuxhint.com/install-centos-7-virtualbox/)
- [Java 11](https://tecadmin.net/install-oracle-java-8-ubuntu-via-ppa/)
- [Tomcat 9](https://linuxize.com/post/how-to-install-tomcat-9-on-ubuntu-20-04/)
- [Maven 3.6.3](https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-20-04/)
- [PostgreSQL 11](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-centos-7) 

> You can also follow the link above and see how to install all the tools you need for this project.


### Find out ip addresses 

When creating virtual machines, you need to specify in the network settings - network bridge. Next, enter the following command in the terminal 

`$ ip addr show`


## Setting up and accessing the Postgresql database

### Basic Setup

1. Switch to the PostgreSQL 
```
$ sudo su - postgres
$ psql
```

2. Add new password to **postgres** user

```# ALTER USER postgres WITH PASSWORD 'postgres';```

3. Create **geozitizen** db to a specific postgres user

```# createdb geocitizen -O postgres```

### Access to db from Ubuntu VM

1.  Edit **pg_hba.conf**

``` $ sudo nano /var/lib/pgsql/data/pg_hba.conf```

In IPv4 local connection change **localhost** to Ubuntu static IP address **all** and change method to **passwd**


___

2. Then edit **postgresql.conf**
``` $ sudo nano /var/lib/pgsql/data/postgresql.conf ```

In listen_addresses change from **0.0.0.0** to __*__.


___

3. After that restart PostgreSQL service for changes to take effect.

```$ sudo systemctl restart postgresql```

4. Add rules to firewall for PostgreSQL service in order for Ubuntu to connect to the database server and restart PostgreSQL to make changes work.

  ```
  $ sudo firewall-cmd --add-service=postgresql
  $ sudo firewall-cmd --add-service=postgresql --permanent
  $ sudo systemctl restart postgres
  ```

## Build and deploy

1. Clone a repository `git clone https://github.com/mentorchita/Geocit134.git; cd Geocit134`

____

2. In **pom.xml** make changes:
    
    - Update the repository url to use HTTPS:

    ```
        <repository>
            <id>org.springframework.maven.milestone</id>
            <name>Spring Maven Milestone Repository</name>
            <url>https://repo.spring.io/milestone</url>
        </repository>
    ```
    
    ```
        <repository>
            <id>spring-milestone</id>
            <name>Spring Maven MILESTONE Repository</name>
            <url>https://repo.spring.io/libs-milestone</url>
        </repository>
    ```

    | From this | To this |
    | --------- | ------- |
    | http://repo.spring.io/milestone | https://repo.spring.io/milestone |
    | https://repo.spring.io/libs-milestone | https://repo.spring.io/libs-milestone
    
    - then comment **DistributionManagement**

    ```
    <!--
        <distributionManagement>
          <repository>
            <id>nexus</id>
            <name>Releases</name>
            <url>http://35.188.29.52:8081/repository/maven-releases</url>
          </repository>
          <snapshotRepository>
            <id>nexus</id>
            <name>Snapshot</name>
            <url>http://35.188.29.52:8081/repository/maven-snapshots</url>
          </snapshotRepository>
        </distributionManagement>
        -->
    ```
   
  ___
   
  3. Change in all files in "Geocit134" directory:
   
   
   ```
   ./src/main/webapp/static/js/app.6313e3379203ca68a255.js.map                                             
   ./src/main/webapp/static/js/vendor.9ad8d2b4b9b02bdd427f.js                                              
   ./src/main/webapp/static/js/vendor.9ad8d2b4b9b02bdd427f.js.map                                          
   ./src/main/webapp/static/js/app.6313e3379203ca68a255.js                                                 
   ./src/main/resources/application.properties                                                             
   ./src/main/java/com/softserveinc/geocitizen/configuration/MongoConfig.java                              
   ./README.md
   ./front-end/src/components/map/main.js                                                                  
   ./front-end/src/main.js                                                                                 
   ./front-end/test/e2e/nightwatch.conf.js                                                                 
   ./front-end/test/e2e/specs/test.js                                                                      
   ./front-end/README.md                                                                                   
   ./front-end/config/index.js
   ```
  
  
  ___
  
  4. Change ip address in **application.properties** in _liquibase_ part - 192.168.43.68: 
  
  ```
  url=jdbc:postgresql://192.168.43.68:5432/geocitizen
  ```
 
  ```
  referenceUrl=jdbc:postgresql://192.168.43.68:5432/geocitizen
  ```

 ___

  5. Then open **http://192.168.43.121:8080/citizen/**