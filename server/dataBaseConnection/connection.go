package dataBaseConnection

import (
	"log"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"

	models "restaurant/models"
	// Importing the models package will automatically migrate the models
)

var dB *gorm.DB

// Connect initializes the database connection and performs migrations.
func Connect() {
	// connecting to the mysql database using gorm
	con, err := gorm.Open(mysql.Open("root:12345678@/restaurant"), &gorm.Config{})
	if err != nil {
		log.Fatalf("Error connecting to database: %v", err)
		panic(err)
	}

	// assign the connection to the global variable
	dB = con

	// Call the function to perform migrations only if they haven't been applied yet
	initializeMigrations()
}

// InitializeMigrations performs database migrations if they haven't been applied yet.
func initializeMigrations() {
	// Check if the table tweet_hashtags doesn't exist.
	if !dB.Migrator().HasTable("tweet_hashtags") {
		// Migrate the models
		if err := dB.AutoMigrate(&models.User{}); err != nil {
			log.Fatalf("failed to auto migrate: %v", err)
		}

	}
}

func GetDB() *gorm.DB {
	return dB
}

func Close() {
	db, err := dB.DB()
	if err != nil {
		log.Fatalf("Error closing database: %v", err)
		panic(err)
	}

	db.Close()
}
