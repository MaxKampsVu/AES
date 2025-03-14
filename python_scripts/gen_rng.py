### Generates random numbers for the masked sbox ###

import random

num_random_numbers = 7

for i in range(num_random_numbers):
    random_number = random.randint(0, 255) 
    binary_number = format(random_number, '08b')
    print(f"r_shares[{i}] = 8\'b{binary_number};")

for i in range(num_random_numbers):
    random_number = random.randint(0, 255)  
    binary_number = format(random_number, '08b')
    print(f"r{i}_and = 8\'b{binary_number};")
