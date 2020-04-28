# Write a function that uses a hash table (dictionary) to 
# find the intersection between two unsorted arrays (lists) and 
# return the elements they have in common as a list. 
# What are the drawbacks of this solution?

# [1, 5, 6, 9]
# [3, 4, 6, 10, 9]
# Return [6, 9]

def get_intersection(list1, list2):
    result = []
    for item in list1:
        if item in list2:
            result.append(item)
    return result