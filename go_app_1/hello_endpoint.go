package go_app_1

import "github.com/gin-gonic/gin"

func SayHello(c IContext) {
	c.JSON(200, gin.H{
		"message": "hello everyone",
	})
}
