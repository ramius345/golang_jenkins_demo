package go_app_1

type IContext interface {
	JSON(code int, obj interface{})
}
