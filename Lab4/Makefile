
FC=gfortran
FFLAGS=-O3 -Wall -Wextra
SRC=heatcop.f90 heat2cop.f90
OBJ=${SRC:.f90=.o}


%.o: %.f90
		$(FC) $(FFLAGS) -o $@ -c $<

burgsnum: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod

heat2.o: heat.o
