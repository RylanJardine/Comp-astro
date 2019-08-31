
FC=gfortran
FFLAGS=-O3 -Wall -Wextra
SRC=heat.f90 heat2.f90
OBJ=${SRC:.f90=.o}


%.o: %.f90
		$(FC) $(FFLAGS) -o $@ -c $<

heat: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod 

heat2.o: heat.o
