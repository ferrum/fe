package re

import (
	"fmt"
	"reflect"
	"regexp"
	"testing"
)

func init() {
	fmt.Printf("init\n")
}

func TestMatch(t *testing.T) {
	pat := regexp.MustCompile("a.c")
	if !pat.MatchString("abc") {
		t.Errorf("/a.c/ didn't match 'abc'")
	}
}

func TestExtractMatches(t *testing.T) {
	pat := regexp.MustCompile("a(.)c")
	matches := pat.FindAllStringSubmatch("abc", -1)
	should := [][]string{[]string{"abc", "b"}}

	if !reflect.DeepEqual(should, matches) {
		t.Errorf("expected %v got %v", matches, should)
	}

	if len(matches) != 1 {
		t.Errorf("Expected 1 match, got %d", len(matches))
	}
	if len(matches[0]) != 2 {
		for _, val := range matches[0] {
			t.Logf("unexpected match %s", val)
		}
		t.Errorf("expected matches[0] to equal 2, got %d", len(matches[0]))
	}

	if matches[0][0] != "abc" {
		t.Errorf("expected full match first")
	}

	if matches[0][1] != "b" {
		t.Logf("unexpected match %s", matches[0][1])
		t.Errorf("expected submatch match second")
	}
}
