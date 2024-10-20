data "google_secret_manager_secret_version" "my_secret" {
  secret  = "mysql-password" 
  project = var.project_id
  version = "latest"
}

resource "google_sql_database_instance" "mysql" {
  name             = "wp-mysql-instance"
  database_version = "MYSQL_8_0"
  region           = "us-central1"

  settings {
    tier = "db-n1-standard-1"  # adjust to fit cost needs
  #  availability_type = "REGIONAL"  # high availability setup
  }
}

resource "google_sql_database" "wordpress_db" {
  name     = "wordpress"
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "root" {
  name     = "root"
  instance = google_sql_database_instance.mysql.name
  password = data.google_secret_manager_secret_version.my_secret.secret_data
}