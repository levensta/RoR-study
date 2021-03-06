require 'sqlite3'

$db

class FtQueryController < ApplicationController
  def index
   
  end

  def create_db
    $db = SQLite3::Database.new "ft_sql.db"
    redirect_to '/'
  end

  def create_table
    clock_watch = $db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS clock_watch (
      ts_id INTEGER PRIMARY KEY AUTOINCREMENT,
      day INTEGER,
      month INTEGER,
      year INTEGER,
      hour INTEGER,
      min INTEGER,
      sec INTEGER,
      race INTEGER,
      name varchar(50),
      lap INTEGER
    );
    SQL
    race = $db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS race (
      r_id INTEGER PRIMARY KEY AUTOINCREMENT,
      start varchar(50)
    );
    SQL

    redirect_to '/'
  end

  def drop_table
    query1 = "DROP TABLE IF EXISTS clock_watch"
    query2 = "DROP TABLE IF EXISTS race"
    $db.execute(query1)
    $db.execute(query2)
    redirect_to '/'
  end

  def start_race
   
  end

  def insert_time_stamp
  
  end

  def delete_last

  end

  def destroy_all
   
  end

  def all_by_name
 
  end

  def all_by_race
   
  end

  def update_time_stamp
  
  end

  private


end
