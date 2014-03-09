/*
 * Copyright 2014 Brian McCallister
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */
package main

import (
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
)

func main() {
	http.HandleFunc("/", Proxy)
	err := http.ListenAndServe(":12345", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func Proxy(rw http.ResponseWriter, req *http.Request) {
	log.Printf("got request!")
	url, err := url.Parse("http://127.0.0.1:12346/v2/keys/")
	if err != nil {
		log.Fatalf("Error parsing url: %s", err)
	}
	rp := httputil.NewSingleHostReverseProxy(url)
	rp.ServeHTTP(rw, req)
}
