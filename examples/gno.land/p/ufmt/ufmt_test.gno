package ufmt

import (
	"fmt"
	"testing"
)

func TestSprintf(t *testing.T) {
	cases := []struct {
		format         string
		values         []interface{}
		expectedOutput string
	}{
		{"hello %s!", []interface{}{"planet"}, "hello planet!"},
		{"hi %%%s!", []interface{}{"worl%d"}, "hi %worl%d!"},
		{"string [%s]", []interface{}{"foo"}, "string [foo]"},
		{"int [%d]", []interface{}{int(42)}, "int [42]"},
		{"uint [%d]", []interface{}{uint(42)}, "uint [42]"},
		{"int64 [%d]", []interface{}{int64(42)}, "int64 [42]"},
		{"uint64 [%d]", []interface{}{uint64(42)}, "uint64 [42]"},
		{"invalid [%d]", []interface{}{"invalid"}, "invalid [(unhandled)]"},
		{"no args", nil, "no args"},
		{"finish with %", nil, "finish with %"},
	}

	for _, tc := range cases {
		name := fmt.Sprintf(tc.format, tc.values...)
		t.Run(name, func(t *testing.T) {
			got := Sprintf(tc.format, tc.values...)
			if got != tc.expectedOutput {
				t.Errorf("got %q, want %q.", got, tc.expectedOutput)
			}
		})
	}
}
