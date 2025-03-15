package main

import (
	"net/http"

	"github.com/a-h/templ"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"moodtracker/views"
)

func main() {
	router := chi.NewRouter()
	router.Use(middleware.Logger)
	router.Get("/favicon.ico", func(w http.ResponseWriter, r *http.Request) { http.ServeFile(w, r, "./static/favicon.ico") })
	router.Get("/static/summer.png", func(w http.ResponseWriter, r *http.Request) { http.ServeFile(w, r, "./static/summer.png") })
	router.Get("/static/winter.png", func(w http.ResponseWriter, r *http.Request) { http.ServeFile(w, r, "./static/winter.png") })
	router.Get("/static/spring.png", func(w http.ResponseWriter, r *http.Request) { http.ServeFile(w, r, "./static/spring.png") })
	router.Get("/static/fall.png", func(w http.ResponseWriter, r *http.Request) { http.ServeFile(w, r, "./static/fall.png") })
	router.Get("/static/style.css", func(w http.ResponseWriter, r *http.Request) { http.ServeFile(w, r, "./static/style.css") })
	router.Get("/", templ.Handler(views.Index()).ServeHTTP)
	http.ListenAndServe(":3000", router)
}
