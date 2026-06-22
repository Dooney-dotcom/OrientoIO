# OrientoIO

[![Java](https://img.shields.io/badge/Java-ED8B00?logo=openjdk&logoColor=white)](https://www.java.com/)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Apache Ant](https://img.shields.io/badge/Apache%20Ant-A81C7D?logo=apacheant&logoColor=white)](https://ant.apache.org/)

## Overview

OrientoIO is a Java-based web application designed to help university students manage their academic journey. The platform provides features for searching and reviewing university courses and exams, managing an academic record book ("libretto"), and comparing different educational plans. 

Built with Java Servlets, JSP (JavaServer Pages), and a custom JDBC database integration, OrientoIO offers a comprehensive interface for students to share experiences through reviews, search for specific universities or courses, and report inappropriate content. The system supports multiple database backends including DB2, HSQLDB, and MySQL.

This demo was created to showcase the project work done for the exam "Ingegneria del Software T" at the University of Bologna in 2023.

## Repository Structure

```
OrientoIO/
├── ant/                           # Apache Ant build scripts
├── docs/                          # Project documentation
│   └── Report.pdf                 # Main project report
├── src/                           # Java source code
│   ├── controller/                # Application controllers
│   ├── db/                        # Database connection and persistence layer
│   ├── model/                     # Data models and business logic
│   ├── servlets/                  # Java Servlets handling HTTP requests
│   └── util/                      # Utility classes
├── web/                           # Web application resources (Frontend)
│   ├── WEB-INF/                   # Web configuration
│   ├── images/                    # Static images
│   ├── scripts/                   # JavaScript files
│   ├── styles/                    # CSS stylesheets
│   └── *.jsp                      # JSP views (reviews, search, login, etc.)
└── .project                       # Eclipse project configuration
```

## Getting Started

### Prerequisites

- Java Development Kit (JDK) 8 or higher
- Apache Ant
- A Servlet Container (e.g., Apache Tomcat)
- A relational database (MySQL, HSQLDB, or DB2)

### Clone the Repository

```bash
git clone https://github.com/Dooney-dotcom/OrientoIO.git
cd OrientoIO
```

### Database Setup

1. Create a database schema named `tw_stud` in your preferred RDBMS (MySQL recommended).
2. Configure your database credentials in the application (if required) to connect successfully.

### Building the Project

Use Apache Ant to build the project. Typically, you can run the following command from the project root if a `build.xml` exists, or navigate to the `ant/` directory:

```bash
ant
```

This will compile the Java sources and package the web application.

### Deployment

Deploy the compiled web application (or the generated WAR file) to your servlet container's `webapps` directory. Start the server and navigate to the application URL (typically `http://localhost:8080/OrientoIO`).

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgements

- **[Java EE](https://javaee.github.io/)** - For the Servlet and JSP APIs.
- **[Apache Ant](https://ant.apache.org/)** - For the build system.
- **[MySQL](https://www.mysql.com/)** - For the database backend.

## Contact

Questions, suggestions, or collaboration opportunities? Feel free to open an issue on the [GitHub repository](https://github.com/Dooney-dotcom/OrientoIO).
