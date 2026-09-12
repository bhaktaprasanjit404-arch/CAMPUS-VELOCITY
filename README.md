# Capacity Connect (CAMPUS-VELOCITY)

A comprehensive Campus Placement & Capacity Management Web Application built with Java Servlets, JSP, JDBC, and MySQL.

---

## Prerequisites

Ensure you have the following installed on your machine:
- **Java Development Kit (JDK)**: JDK 17 or higher (JDK 17 LTS / JDK 21 LTS recommended)
- **Apache Tomcat**: Tomcat 10.1.x or Tomcat 11.x (Jakarta EE compatible)
- **Apache NetBeans IDE**: Version 19, 20, 21, 22, or newer
- **MySQL Database Server**: MySQL Server 8.0 or newer

---

## Step-by-Step Setup Guide in Apache NetBeans

### 1. Database Setup
1. Start your local **MySQL Server** (via MySQL Workbench, XAMPP, or Command Line).
2. Open and execute the SQL script located at:
   `WebApplication1/web/database/database.sql`
   This creates the `capacity_connect` database and all required tables with sample data.
3. If your MySQL root password is not `Prasan@1234`, you can easily configure it:
   - Edit `WebApplication1/src/conf/db.properties`:
     `properties
     db.url=jdbc:mysql://localhost:3306/capacity_connect?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
     db.user=root
     db.password=YOUR_MYSQL_PASSWORD
     `
   - Alternatively, set the environment variables `DB_USER` and `DB_PASSWORD`.

---

### 2. Configure Tomcat Server in NetBeans
If you haven't already registered Tomcat in NetBeans:
1. Open **Apache NetBeans**.
2. Go to **Tools** -> **Servers**.
3. Click **Add Server...**.
4. Select **Apache Tomcat or TomEE** and click **Next**.
5. Browse and select your Tomcat installation directory (e.g. `C:\apache-tomcat-11.x` or `D:\apache-tomcat-11.x`).
6. Set a Tomcat manager username/password (or leave defaults) and click **Finish**.

---

### 3. Open the Project in NetBeans
1. In NetBeans, go to **File** -> **Open Project...**.
2. Navigate into the cloned repository folder:
   `CAMPUS-VELOCITY / WebApplication1`
3. Select **WebApplication1** (marked with the NetBeans web project icon) and click **Open Project**.

---

### 4. Resolve Server (If prompted)
If NetBeans shows a yellow exclamation mark or asks for a server runtime:
1. Right-click the project **CAPACITY-CONNECT** (or **WebApplication1**) -> **Properties**.
2. Go to the **Run** category.
3. Select your installed **Server** (e.g., *Apache Tomcat or TomEE*).
4. Select **Java EE Version**: *Jakarta EE 10* or *Jakarta EE 11 Web*.
5. Click **OK**.

---

### 5. Build and Run
1. Right-click the project -> **Clean and Build**.
2. Right-click the project -> **Run** (or press F6).
3. NetBeans will automatically deploy the application to Tomcat and open your browser at:
   `http://localhost:8080/CAPACITY-CONNECT/`
