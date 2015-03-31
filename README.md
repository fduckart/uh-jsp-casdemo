A JSP application demonstrating how to use the UH CAS 3 service.

**Build Tool**
First, you need to download and install maven (version 3.0.4).
Be sure to set up a M2_REPO environment variable.

**Java**
You'll need a Java JDK to build and run the project (version 1.7).

**Apache Tomcat**
Install Apache Tomcat.
This demonstration application was developed with version 7.0.21.
You will need to enable the SSL connector in conf/server.xml

**Source Code Library Dependencies**
See the build pom.xml file to see the various code dependencies.

**Operating System**
The application was developed on Mac OS X, but should run on any
platform that has the above mentioned Java and Tomcat installed.

**Source code Files**
The files for the project are kept in a git code repository:
https://github.com/fduckart/uh-jsp-casdemo

**Building**
Install the necessary project dependencies:

    $ mvn install

To build a deployable war file for local development:

    $ mvn clean package

You should have a deployable war file in the target directory.
Deploy as usual in a servlet container, e.g. tomcat.

**Running the Application locally**
http://localhost:8080/casjspdemo/

Note that your browser may require that you create a security
exception in order to use localhost and UH CAS 3.

**Screenshots of Typical Usage**
Screenshots can be found in the docs directory here:
https://github.com/fduckart/uh-jsp-casdemo/tree/master/docs

![Step One][uhcasjsp-screenshot-001]

**Important Note**
This demo application uses the UH cas-test service.
You may need to contact the IAM group and ask that they
refresh any UH user names you intend to use. See here:
https://www.hawaii.edu/bwiki/display/UHIAM/CAS3+Developer+Documentation

