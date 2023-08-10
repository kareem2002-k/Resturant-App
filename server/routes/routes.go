package routes

import (
	"github.com/gofiber/fiber/v2"

	"restaurant/controllers"
)

func Setup(app *fiber.App) {

	app.Post("/register", controllers.Register) // tested
	app.Post("/login", controllers.Login)

	app.Post("/logout", controllers.LogOut) // tested

	app.Use(controllers.AuthMiddleware) // Register the AuthMiddleware first

	app.Get("/user", controllers.GetUserData) // tested

	app.Post("/order", controllers.CreateOrder) // tested

	app.Get("/currentorder", controllers.GetOrder) // tested

	app.Post("/deleteorder", controllers.DeleteOrder) // tested

	app.Get("/allorders", controllers.GetAllOrders) // tested

	app.Post("/ReciveOrder", controllers.OrderRecive) // tested

	// TODO: test this
}
