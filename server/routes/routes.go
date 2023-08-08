package routes

import (
	"github.com/gofiber/fiber/v2"

	"restaurant/controllers"
)

func Setup(app *fiber.App) {

	app.Post("/register", controllers.Register) // tested
	app.Post("/login", controllers.Login)

	app.Use(controllers.AuthMiddleware) // Register the AuthMiddleware first

	app.Get("/user", controllers.GetUserData) // tested

	app.Post("/order", controllers.CreateOrder) // tested

	app.Post("/logout", controllers.LogOut) // tested

	app.Get("/orders", controllers.GetOrder) // tested

	// TODO: test this
}
