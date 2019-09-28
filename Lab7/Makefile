FC=gfortran
FFLAGS=-O3 -Wall -Wextra -fdefault-real-8 -fdefault-double-8
# FFLAGS=-O3 -Wall -Wextra -freal-4-real-16
SRC=grid.f90 physics.f90 flux.f90 init.f90 output.f90 step.f90 solver.f90
OBJ=${SRC:.f90=.o}


%.o: %.f90
		$(FC) $(FFLAGS) -o $@ -c $<

solve: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod
