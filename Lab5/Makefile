
FC=gfortran
FFLAGS=-O3 -Wall -Wextra
SRC=output.f90 output2.f90 numsol.f90 numsol2.f90 solver.f90
OBJ=${SRC:.f90=.o}


%.o: %.f90
		$(FC) $(FFLAGS) -o $@ -c $<

ftcs: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod

heat2.o: heat.o
