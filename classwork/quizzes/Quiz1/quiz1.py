
def compute_sum_iteratively(num):
    sum = 0
    for i in range(1, num+1):
        sum += i
    return sum
print(compute_sum_iteratively(2))

def compute_sum_recursively(num):
    if num == 0 or num == 1:
        return num
    if num > 1:
        return num + compute_sum_recursively(num - 1)
print(compute_sum_recursively(2))