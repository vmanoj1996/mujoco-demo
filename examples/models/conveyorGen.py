
file = open("objectsGen.xml", 'r')
newcontent = file.read()
file.close()

z = 0.25
objectHeight = 0.045
index = 0
while 1==1:

    searchString = '$' + str(index) + '$'
    if searchString in newcontent:
        newcontent = newcontent.replace(searchString, str(z))
    else:
        break
    index=index+1
    z = z + objectHeight

print(newcontent)
    
file2 = open("objects.xml", 'w');
file2.write(newcontent)
file2.close()