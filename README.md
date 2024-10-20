# Steps to Deploy 

1. Prepare database for deployment 

```sh
cds add hana 
```

run `npm i` to install the dependencies. 


2. Add XSUAA Configuration to the project 

```sh 
cds add xsuaa 
```

This step will create a file called `xs-security.json`. In this file, we maintain the roles and user attributes. 

run `npm i` to install the dependencies.


3. Build the project to deploy. 

```sh
cds build --for hana
```

This is optional build command. The project will be build during deployment. 

4. Generate the MTA File for deployment. 

```sh
cds add mta
```

run the following command to freeze dependencies. 

```sh
npm update --package-lock-only
```

### What is in the MTA file?

#### General Section

This section is about the version of Yaml used for defining the configuration. The Name of the mta project. 
and the steps to be done when the build is executed. 

```yaml
_schema-version: 3.3.0
ID: incidentmanage
version: 1.0.0
description: "A simple CAP project."
parameters:
  enable-parallel-deployments: true
build-parameters:
  before-all:
    - builder: custom
      commands:
        - npm ci
        - npx cds build --production
```

#### Modules 

The project we are deploying has two modules. 

1. CAP Server 
    - Running instance of the CAP Server
2. DB Deployer 
    - Deploy the DB artifacts in the hana database. 


###### CAP Server 

```yaml 
  - name: incidentmanage-srv
    type: nodejs
    path: gen/srv
    parameters:
      buildpack: nodejs_buildpack
      readiness-health-check-type: http
      readiness-health-check-http-endpoint: /health
    build-parameters:
      builder: npm
    provides:
      - name: srv-api # required by consumers of CAP services (e.g. approuter)
        properties:
          srv-url: ${default-url}
    requires:
      - name: incidentmanage-db
      - name: incidentmanage-auth
```

###### DB Deployer

```yaml
  - name: incidentmanage-db-deployer
    type: hdb
    path: gen/db
    parameters:
      buildpack: nodejs_buildpack
    requires:
      - name: incidentmanage-db
```


#### Resources 

1. Database Instance 

```yaml
  - name: incidentmanage-db
    type: com.sap.xs.hdi-container
    parameters:
      service: hana
      service-plan: hdi-shared
``` 

2. Authorisation Instance 

```yaml
  - name: incidentmanage-auth
    type: org.cloudfoundry.managed-service
    parameters:
      service: xsuaa
      service-plan: application
      path: ./xs-security.json
      config:
        xsappname: incidentmanage-${org}-${space}
        tenant-mode: dedicated
```

Right click on the mta.yaml to build the project. This will generate a mtar file mta_archives folder. 

Right click on the mtar file and Deploy MTA Archive. 

Useful CF Commands 