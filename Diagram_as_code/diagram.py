from diagrams import Diagram
from diagrams import Cluster
from diagrams import Edge
from diagrams.custom import Custom

with Diagram("Geocitizen App", show=False):
    ci = Custom("Jenkins", "resources/Jenkins.png")
    conf_host = Custom("Terraform", "resources/Terraform.png")
    devops = Custom("DevOps", "resources/DevOps.png")
    conf_code = Custom("Ansible", "resources/Ansible.png")
    user = Custom("User", "resources/User.png")

    with Cluster("Ubuntu Server"):
        webserver = Custom("Tomcat", "resources/Tomcat.png")
        builder = Custom("Maven", "resources/Maven.png")
        app = Custom("Geocitizen", "resources/Geocitizen.png")

    with Cluster("CentOs"):
        DB = Custom("PostgreSql", "resources/Postgresql.png")

    devops >> ci >> Edge(color = "red", label = "Step1") >> conf_host >> webserver
    conf_host >> DB
    ci << Edge(color = "red", label = " response data") << conf_host
    webserver >> DB
    DB >> webserver
    builder >> app
    ci >> Edge(color = "red", label = "Step2") >> conf_code >> webserver
    conf_code >> DB
    webserver << user
    webserver >> app
    app >> webserver