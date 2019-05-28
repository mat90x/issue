// This source is narrated by video https://www.youtube.com/watch?v=OkIy-6qOhxE
package main

import (
    "fmt"
    "io"
    "math/rand"
    "net/http"
    "os"
    "path"
    "time"
)

func GetHandler(w http.ResponseWriter, r *http.Request) {
    name := r.URL.EscapedPath()
    name = name[1:]

    f, err := os.Open(name)
    if err != nil {
        if os.IsNotExist(err) {
            http.NotFound(w, r)
            return
        }
        http.Error(w, "error on get: can't retrieve file", http.StatusInternalServerError)
        return
    }

    _, err = io.Copy(w, f)
    if err != nil {
        f.Close()
        http.Error(w, "error on get: can't download file", http.StatusInternalServerError)
        return
    }
}

func PutHandler(w http.ResponseWriter, r *http.Request) {
    name := r.URL.EscapedPath()
    name = name[1:]

    tokenstr := "file_repo_" + fmt.Sprintf("%d", rand.Uint32())
    err := os.Mkdir(tokenstr, 0700)
    if err != nil {
        if os.IsExist(err) {
            http.Error(w, "error on put: folder exists", http.StatusInternalServerError)
            return
        }
    }

    name = path.Join(tokenstr, name)

    f, err := os.Create(name)
    if err != nil {
        http.Error(w, "error on put: can't create file", http.StatusInternalServerError)
        return
    }

    _, err = io.Copy(f, r.Body)
    if err != nil {
        f.Close()
        http.Error(w, "error on put: can't upload file", http.StatusInternalServerError)
        return
    }

    f.Close()

    fmt.Fprintln(w, "http://localhost:8080/" + name)
    fmt.Println(name)
}

func Handler(w http.ResponseWriter, r *http.Request) {
    if r.Method == http.MethodGet {
        GetHandler(w, r)
        return
    }
    if r.Method == http.MethodPut {
        PutHandler(w, r)
        return
    }

    http.NotFound(w, r)
}

func main() {
    rand.Seed(time.Now().UnixNano())
    http.HandleFunc("/", Handler)
    http.ListenAndServe(":8080", nil)
}
