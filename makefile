versione=`cat VERSION`

crea:
	mix hex.build
	git tag -a $(versione) -m $(versione)
	git push origin $(versione)
pub: 
	mix hex.publish
