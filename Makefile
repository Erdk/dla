CXX=g++
CXXFLAGS=-O3 -march=native

all: o1

clean:
	rm -f o1

.PHONY: all clean

o1: o1.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

gen: o1
	./o1 | sort | uniq> >> o1.pde
	ehco "}" >> o1.pde
