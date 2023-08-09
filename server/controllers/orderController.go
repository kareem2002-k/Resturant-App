package controllers

import (
	"restaurant/dataBaseConnection"
	"restaurant/models"
	"time"

	"github.com/gofiber/fiber/v2"

	"fmt"
)

func CreateOrder(c *fiber.Ctx) error {
	// Parse request body to get order data
	var data map[string]interface{}

	// get the database connection
	var db = dataBaseConnection.GetDB()

	if err := c.BodyParser(&data); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Error parsing body",
		})
	}

	user, ok := c.Locals("user").(models.User)
	if !ok {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Internal server error fuck",
			"user":    user,
		})
	}
	// Extract products from data["products"]
	productsInterface, ok := data["products"].([]interface{})
	if !ok {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid products format",
		})
	}

	// Create the order
	total := calculateTotalPrice(productsInterface)
	order := models.Order{
		UserID:   user.ID,
		Total:    total,
		Status:   "pending",
		CreateAt: time.Now().Format("2006-01-02 15:04:05"),
	}

	// Save the order to the database
	if err := db.Create(&order).Error; err != nil {
		fmt.Printf("Error creating order: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error creating order",
		})
	}

	// Create order items and associate with the order
	var orderItems []models.OrderItem
	for _, productInterface := range productsInterface {
		product, ok := productInterface.(map[string]interface{})
		if !ok {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
				"message": "Invalid product format",
			})
		}

		productID, _ := product["product_id"].(float64)
		orderItems = append(orderItems, models.OrderItem{
			OrderID:   order.ID,
			ProductID: uint64(productID),
		})
	}

	// update the user's current order id
	if err := db.Model(&user).Update("current_order_id", order.ID).Error; err != nil {
		fmt.Printf("Error updating user's current order id: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error updating user's current order id",
		})
	}

	// Save the order items to the database
	if err := db.Create(&orderItems).Error; err != nil {
		fmt.Printf("Error creating order items: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Error creating order items",
		})
	}

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"message": "Order created successfully",
	})
}

// Calculate total price of products
func calculateTotalPrice(products []interface{}) uint64 {
	var total uint64
	for _, productInterface := range products {
		product, ok := productInterface.(map[string]interface{})
		if !ok {
			continue
		}

		price, _ := product["price"].(float64)
		total += uint64(price)
	}
	return total
}

func GetOrder(c *fiber.Ctx) error {
	// Get the database connection
	var db = dataBaseConnection.GetDB()

	// Get the user from the context
	user, ok := c.Locals("user").(models.User)
	if !ok {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Internal server error",
		})
	}

	if user.CurrentOrderID == 0 {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Order not found",
		})
	}

	// Get the order from the database
	var order models.Order
	if err := db.Where("id = ?", user.CurrentOrderID).First(&order).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{

			"message": "Internal server error",
		})
	}

	return c.JSON(fiber.Map{
		"message": "Success",
		"orders":  order,
	})
}

func GetAllOrders(c *fiber.Ctx) error {
	// Get the database connection
	var db = dataBaseConnection.GetDB()

	// Get the user from the context
	user, ok := c.Locals("user").(models.User)
	if !ok {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Internal server error",
		})
	}

	if user.CurrentOrderID == 0 {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Order not found",
		})
	}

	// Get the order from the database
	var order models.Order
	if err := db.Where("id = ?", user.CurrentOrderID).First(&order).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{

			"message": "Internal server error",
		})
	}

	return c.JSON(fiber.Map{
		"message": "Success",
		"orders":  order,
	})
}
