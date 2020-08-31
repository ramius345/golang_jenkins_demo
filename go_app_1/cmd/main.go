package main

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/ramius345/golang_jenkins_demo/go_app_1"
)

func main() {
	fmt.Println("Hello")
	r := gin.Default()
	r.GET("/hello", func(c *gin.Context) { go_app_1.SayHello(c) })
	r.Run()
}
