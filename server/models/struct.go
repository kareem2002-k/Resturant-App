package models

type User struct {
	ID       uint64 `gorm:"primary_key;auto_increment" json:"id"`
	Email    string `gorm:"size:255;not null;unique" json:"email"`
	Password []byte `gorm:"size:255;not null;" json:"password"`
	Fullname string `gorm:"size:255;not null;" json:"fullname"`
	CreateAt string `gorm:"not null;" json:"createAt"`
}
