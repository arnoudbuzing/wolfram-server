package main

import (
	"os"
	"bytes"
	"fmt"
	"io/ioutil"
	"net/http"
)

func main() {
    url := "http://127.0.0.1:5858"
    fmt.Println("URL:>", url)

    var jsonStr = []byte(os.Args[1])
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonStr))
    req.Header.Set("Content-Type", "application/json")

    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        panic(err)
    }
    defer resp.Body.Close()

    fmt.Println("response Status:", resp.Status)
    fmt.Println("response Headers:", resp.Header)
    body, _ := ioutil.ReadAll(resp.Body)
    fmt.Println("response Body:", string(body))
}
