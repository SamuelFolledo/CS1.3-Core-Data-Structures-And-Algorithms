#!python

def contains(text, pattern):
    """Return a boolean indicating whether pattern occurs in text."""
    assert isinstance(text, str), 'text is not a string: {}'.format(text)
    assert isinstance(pattern, str), 'pattern is not a string: {}'.format(text)
    # TODO: Implement contains here (iteratively and/or recursively)
    #1) Turn text and pattern into array which only contains letters and spaces
    text_arr = "".join(c.lower() for c in text if c.isalpha()) #turn text to array of strings which only contains alpha characters (no numbers, symbols, whitespaces)
    pattern_arr = "".join(c.lower() for c in pattern if c.isalpha()) #turn patterns to array
    #2) Handle empty pattern_arr
    if len(pattern_arr) == 0: #handle if pattern_arr is empty, then return true
        return True
    # return contains_iteratively(text_arr, pattern_arr)
    return contains_recursively(text_arr, pattern_arr)

def contains_iteratively(text_arr, pattern_arr):
    pattern_index = 0
    if len(pattern_arr) > len(text_arr): ## error handler if pattern has more character than text..
        return False
    for i in range(len(text_arr)): #loop through each char in arr
        if text_arr[i] != pattern_arr[pattern_index]: #check if characters does not match, reset pattern_index
            pattern_index = 0
        if text_arr[i] == pattern_arr[pattern_index]: #if text char match with pattern char
            pattern_index += 1
            if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
                return True
    return False

def contains_recursively(text_arr, pattern_arr, text_index=0, pattern_index=0):
    if text_index == len(text_arr): #if text_index go out of bounds, return False
        return False
    if text_arr[text_index] != pattern_arr[pattern_index]: #check if characters does not match, pattern_index = 0
        pattern_index = 0
    if text_arr[text_index] == pattern_arr[pattern_index]: #if text char match with pattern char, move to next character
        pattern_index += 1
        if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
            return True    
    return contains_recursively(text_arr, pattern_arr, text_index+1, pattern_index)

def find_index(text, pattern):
    """Return the starting index of the first occurrence of pattern in text,
    or None if not found."""
    assert isinstance(text, str), 'text is not a string: {}'.format(text)
    assert isinstance(pattern, str), 'pattern is not a string: {}'.format(text)
    # TODO: Implement find_index here (iteratively and/or recursively)
    #1) Turn text and pattern into array which only contains letters and spaces
    text_arr = "".join(c.lower() for c in text if c.isalpha() or c.isspace()) #turn text to array of strings which only contains alpha and whitespace characters (no numbers, symbols)
    pattern_arr = "".join(c.lower() for c in pattern if c.isalpha() or c.isspace()) #turn patterns to array
    #2) Handle empty pattern_arr
    if len(pattern_arr) == 0:
        return 0 #return first index
    #3) Look for first index of pattern in text
    # index = find_index_iteratively(text_arr, pattern_arr)
    index = find_index_recursively(text_arr, pattern_arr)
    return index

def find_index_iteratively(text_arr, pattern_arr):
    pattern_index = 0
    for i in range(len(text_arr)): #loop through each char in arr
        if text_arr[i] != pattern_arr[pattern_index]: #check if characters does not match, reset pattern_index
            pattern_index = 0
        if text_arr[i] == pattern_arr[pattern_index]: #if text char match with pattern char
            pattern_index += 1
            if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
                return i + 1 - pattern_index #return (i + 1) - pattern_index
    return None

def find_index_recursively(text_arr, pattern_arr, text_index=0, pattern_index=0):
    if text_index > len(text_arr) - 1: #if text_index go out of bounds, then we reached the end without finding index
        return None
    if text_arr[text_index] != pattern_arr[pattern_index]: #check if characters does not match, pattern_index = 0
        pattern_index = 0
    if text_arr[text_index] == pattern_arr[pattern_index]: #if text char match with pattern char, move to next character
        pattern_index += 1
        if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
            return text_index + 1 - pattern_index #return (i + 1) - pattern_index  
    return find_index_recursively(text_arr, pattern_arr, text_index+1, pattern_index)

def find_all_indexes(text, pattern):
    """Return a list of starting indexes of all occurrences of pattern in text,
    or an empty list if not found."""
    assert isinstance(text, str), 'text is not a string: {}'.format(text)
    assert isinstance(pattern, str), 'pattern is not a string: {}'.format(text)
    # TODO: Implement find_all_indexes here (iteratively and/or recursively)
    #1) Turn text and pattern into array which only contains letters and spaces
    text_arr = "".join(c.lower() for c in text if c.isalpha() or c.isspace()) #turn text to array of strings which only contains alpha and whitespace characters (no numbers, symbols)
    pattern_arr = "".join(c.lower() for c in pattern if c.isalpha() or c.isspace()) #turn patterns to array
    #2) Handle empty pattern_arr
    if len(pattern_arr) == 0: #if pattern_arr is empty, then indexes is all pattern's indexes
        indexes = []
        for i in range(len(text_arr)): #populate indexes by index of text_arr
            indexes.append(i)
        return indexes
    #3) Look for all indexes Iteratively and Recursively
    # indexes = find_all_indexes_iteratively(text_arr, pattern_arr, [])
    indexes = find_all_indexes_recursively(text_arr, pattern_arr, [])
    # print(f"RESULT: '{pattern}' is in {text} at indexes {indexes}\n")
    return indexes

def find_all_indexes_iteratively(text_arr, pattern_arr, indexes, pattern_index = 0):
    for i in range(len(text_arr)): #loop through each char in text_arr
        if text_arr[i] != pattern_arr[pattern_index]: #check if characters does not match, reset pattern_index
            pattern_index = 0
        if text_arr[i] == pattern_arr[pattern_index]: #if text char match with pattern char
            pattern_index += 1
            if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
                indexes.append(i + 1 - pattern_index) #return (i + 1) - pattern_index
                pattern_index = 0
                for j in range(len(pattern_arr)): #handles overlaps
                    if text_arr[i-j] == pattern_arr[pattern_index-j] and len(pattern_arr) > j+1: #to handle overlaps, if pattern_arr[pattern_index - j] is same as text[i-j] and the length of pattern_arr is not past j+1 then increment pattern_index
                        pattern_index += 1
                    else:
                        break
    return indexes

def find_all_indexes_recursively(text_arr, pattern_arr, indexes=[], text_index=0, pattern_index=0):
    if text_index > len(text_arr) - 1: #if out of bounds, return indexes
        return indexes
    if text_arr[text_index] != pattern_arr[pattern_index]: #check if characters does not match, reset pattern_index
        pattern_index = 0
    if text_arr[text_index] == pattern_arr[pattern_index]: #if text char match with pattern char
        pattern_index += 1
        if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
            indexes.append(text_index + 1 - pattern_index) #return (i + 1) - pattern_index
            pattern_index = 0 #reset pattern_index
            for j in range(len(pattern_arr)): #handles overlaps. Idk how to handle overlaps do it recursively
                if text_arr[text_index-j] == pattern_arr[pattern_index-j] and len(pattern_arr) > j+1: #to handle overlaps, if pattern_arr[pattern_index - j] is same as text[i-j] and the length of pattern_arr is not past j+1 then increment pattern_index
                    pattern_index += 1
                else:
                    break
    return find_all_indexes_recursively(text_arr, pattern_arr, indexes, text_index+1, pattern_index)

def test_string_algorithms(text, pattern):
    found = contains(text, pattern)
    print('contains({!r}, {!r}) => {}'.format(text, pattern, found))
    # TODO: Uncomment these lines after you implement find_index
    index = find_index(text, pattern)
    print('find_index({!r}, {!r}) => {}'.format(text, pattern, index))
    # TODO: Uncomment these lines after you implement find_all_indexes
    indexes = find_all_indexes(text, pattern)
    print('find_all_indexes({!r}, {!r}) => {}'.format(text, pattern, indexes))

def main():
    """Read command-line arguments and test string searching algorithms."""
    import sys
    args = sys.argv[1:]  # Ignore script file name
    if len(args) == 2:
        text = args[0]
        pattern = args[1]
        test_string_algorithms(text, pattern)
    else:
        script = sys.argv[0]
        print('Usage: {} text pattern'.format(script))
        print('Searches for occurrences of pattern in text')
        print("\nExample: {} 'abra cadabra' 'abra'".format(script))
        print("contains('abra cadabra', 'abra') => True")
        print("find_index('abra cadabra', 'abra') => 0")
        print("find_all_indexes('abra cadabra', 'abra') => [0, 8]")

if __name__ == '__main__':
    main()