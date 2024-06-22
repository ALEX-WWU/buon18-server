package routes

import (
	"server/controllers"
	"server/middlewares"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func User(e *gin.Engine, db *gorm.DB) {
	handler := controllers.UserHandler{DB: db}

	router := e.Group("/users", middlewares.Authenticate())
	{
		router.GET("/", middlewares.Authorize(middlewares.Editor), handler.List)
		router.POST("/", middlewares.Authorize(middlewares.Admin), handler.Create)
	}
}
