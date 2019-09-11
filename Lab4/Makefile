
FC=gfortran
FFLAGS=-O3 -Wall -Wextra
SRC=burgery.f90 burginator.f90 new2.f90 new.f90
OBJ=${SRC:.f90=.o}


%.o: %.f90
		$(FC) $(FFLAGS) -o $@ -c $<

burgsnum: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod

heat2.o: heat.o
