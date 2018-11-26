% ------------- unit 9: some things not treated 

% complex arithmetic
a=5+i
b=i;
b^2
whos a

% sparse arrays
a=sparse(10,10);
a(1,4)=2;
a(3,4)=-3;
whos a
a
a^2
a.^2
a(1,1)

