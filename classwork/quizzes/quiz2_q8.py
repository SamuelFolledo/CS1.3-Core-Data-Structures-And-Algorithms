# Write a function that will reverse a integer number using a stack and return the reversed number as an integer. 
# For example, if your input number is 3479 the function will return 9743. 

def reverse_num(nums):
    stack = ""
    for num in str(nums):
        # stack.insert(len(stack),num) #if stack was an array
        stack = num + stack
    return int(stack)

print(reverse_num(12345))