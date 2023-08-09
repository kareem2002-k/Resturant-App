package controllers

import (
	"github.com/gofiber/fiber/v2"

	"restaurant/models"
)

func GetUserData(c *fiber.Ctx) error {

	// get auth user data from locals
	user, ok := c.Locals("user").(models.User)
	if !ok {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Internal server error fuck",
			"user":    user,
		})
	}

	// At this point, the user's data, including their likes and tweets, is fetched successfully
	return c.JSON(fiber.Map{
		"user": user,
	})

}
