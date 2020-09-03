package go_app_1

import (
	"testing"

	"github.com/gin-gonic/gin"
)

type TestJson struct {
	codes    []int
	messages []gin.H
}

func (c *TestJson) JSON(code int, data interface{}) {
	c.codes = append(c.codes, code)

	ginH, ok := data.(gin.H)
	if ok {
		c.messages = append(c.messages, ginH)
	}
}

func TestHello(t *testing.T) {
	//Given a testing context
	testJson := &TestJson{}

	//When I run say hello on the context
	SayHello(testJson)

	//expect a code of 200
	if len(testJson.codes) != 1 && testJson.codes[0] != 200 {
		t.Errorf("Got incorrect response code!")
	}

	//and then expect a message
	if len(testJson.messages) != 1 {
		t.Errorf("Expected a message!\n")
	}

	message, ok := testJson.messages[0]["message"]

	if !ok {
		t.Errorf("Didn't have message field in message!\n")
	}

	data, ok := message.(string)
	if !ok {
		t.Errorf("Message wasn't a string\n")
	}

	if data != "hello demo" {
		t.Errorf("Message wasnt trigger!\n")
	}
}
