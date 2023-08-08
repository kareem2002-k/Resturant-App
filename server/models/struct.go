package models

type User struct {
	ID       uint64 `gorm:"primary_key;auto_increment" json:"id"`
	Email    string `gorm:"size:255;not null;unique" json:"email"`
	Password []byte `gorm:"size:255;not null;" json:"password"`
	Fullname string `gorm:"size:255;not null;" json:"fullname"`
	CreateAt string `gorm:"not null;" json:"createAt"`
}

// make an order item
type OrderItem struct {
	ID        uint64 `gorm:"primary_key;auto_increment" json:"id"`
	OrderID   uint64 `gorm:"not null;" json:"order_id"`
	ProductID uint64 `gorm:"not null;" json:"product_id"`
}

// make an order
type Order struct {
	ID       uint64 `gorm:"primary_key;auto_increment" json:"id"`
	UserID   uint64 `gorm:"not null;" json:"user_id"`
	Total    uint64 `gorm:"not null;" json:"total"`
	Status   string `gorm:"not null;" json:"status"`
	CreateAt string `gorm:"not null;" json:"createAt"`
}

// make a product
type Product struct {
	ID       uint64 `gorm:"primary_key;auto_increment" json:"id"`
	Name     string `gorm:"size:255;not null;" json:"name"`
	Price    uint64 `gorm:"not null;" json:"price"`
	Category string `gorm:"not null;" json:"category"`
}
