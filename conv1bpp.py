with open("ripoff.bin", 'rb') as file:
    byte_array = bytearray(file.read())
#first we cut off every even byte in file
j = 0
for i in range(0,len(byte_array)):
    if i % 2 == 0:
        byte_array.pop(j)
        j += 1
j = 0
l = bytearray()
#then we make 1bpp bitmap by bitshifting each byte that ain't 0
for i in range(0,len(byte_array)//8):
    k = 0
    for j in range(j,j+8):
        k = k << 1
        if byte_array[j] != 0:
            k += 1
    j+=1
    print(hex(k))
    l.append(k)
#print(len(byte_array))
with open("test.bin", "wb") as file:
    file.write(l)
