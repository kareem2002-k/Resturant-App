package main

import (
	"restaurant/dataBaseConnection"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"

	"restaurant/routes"
)

func main() {

	dataBaseConnection.Connect()

	app := fiber.New()

	// Routes

	routes.Setup(app)

	// CORS
	app.Use(cors.New(cors.Config{
		AllowCredentials: true,
		AllowHeaders:     "Origin, Content-Type, Accept",
		AllowMethods:     "GET, POST, PUT, DELETE, OPTIONS",
		AllowOrigins:     "http://localhost:3000", // Replace with your allowed origin(s)

	}))

	app.Listen(":8000")

}
