file=fcreate("system.dat",0)

declare aa[adir("system.dat")]
declare bb[adir("system.dat")]
adir("system.dat",,,aa,bb)

store aa[1] to s1
store bb[1] to s2

s1=transform(s1,"@!")
s2=transform(s2,"@!")

s1=strtran(s1,"/","")
s2=strtran(s2,":","")

c1=bin2i(s1)
c2=bin2i(s2)

tc1=len(s1)
tc2=len(s2)

fwrite(file,s1,tc1)
fwrite(file,s2,tc2)
