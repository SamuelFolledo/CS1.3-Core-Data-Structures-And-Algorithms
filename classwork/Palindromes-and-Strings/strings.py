#!python

def contains(text, pattern):
    """Return a boolean indicating whether pattern occurs in text."""
    assert isinstance(text, str), 'text is not a string: {}'.format(text)
    assert isinstance(pattern, str), 'pattern is not a string: {}'.format(text)
    # TODO: Implement contains here (iteratively and/or recursively)
    # return contains_iteratively(text, pattern)
    return contains_recursively(text, pattern)

def contains_iteratively(text, pattern):
    text_arr = "".join(c.lower() for c in text if c.isalpha()) #turn text to array of strings which only contains alpha characters (no numbers, symbols, whitespaces)
    pattern_arr = "".join(c.lower() for c in pattern if c.isalpha()) #turn patterns to array
    pattern_index = 0
    if len(pattern_arr) == 0: #handle if pattern_arr is empty, then return true
        return True
    elif len(pattern_arr) > len(text_arr): ## error handler if pattern has more character than text..
        return False
    for i in range(len(text_arr)): #loop through each char in arr
        if text_arr[i] != pattern_arr[pattern_index]: #check if characters does not match, reset pattern_index
            pattern_index = 0
        if text_arr[i] == pattern_arr[pattern_index]: #if text char match with pattern char
            # print(f"\tMATCH {text_arr[i]} and {pattern_arr[pattern_index]} {len(pattern_arr)}")
            pattern_index += 1
            if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
                # print(f"\t\tFULL match! {text_arr[i]}={pattern_arr[pattern_index]}")
                return True
    return False

def contains_recursively(text, pattern, text_index=0, pattern_index=0):
    text_arr = "".join(c.lower() for c in text if c.isalpha()) #turn text to array of strings which only contains alpha characters (no numbers, symbols, whitespaces)
    pattern_arr = "".join(c.lower() for c in pattern if c.isalpha()) #turn patterns to array
    if len(pattern_arr) == 0: #handle if pattern_arr is empty, then return true
        return True
    elif len(pattern_arr) > len(text_arr): ## error handler if pattern has more character than text..
        return False
    if text_index > len(text_arr) - 1: #if text_index go out of bounds, return False
        return False
    # print(f"DOES {text} match {pattern}?")
    if text_arr[text_index] != pattern_arr[pattern_index]: #check if characters does not match, pattern_index = 0
        # print(f"NOPE {text_arr[text_index]} != {pattern_arr[pattern_index]}")
        pattern_index = 0
        # return contains_recursively(text, pattern, text_index+1, pattern_index)
    if text_arr[text_index] == pattern_arr[pattern_index]: #if text char match with pattern char, move to next character
        # print(f"\tMATCH {text_arr[text_index]} and {pattern_arr[pattern_index]}\t{pattern_index}-{len(pattern_arr)}")
        pattern_index += 1
        if pattern_index == len(pattern_arr): #if the entire pattern char matches, return True
            # print(f"\t\tFULL match! {text_arr[text_index]}={pattern_arr[pattern_index-1]}")
            return True    
    return contains_recursively(text, pattern, text_index+1, pattern_index)

def find_index(text, pattern):
    """Return the starting index of the first occurrence of pattern in text,
    or None if not found."""
    assert isinstance(text, str), 'text is not a string: {}'.format(text)
    assert isinstance(pattern, str), 'pattern is not a string: {}'.format(text)
    # TODO: Implement find_index here (iteratively and/or recursively)


def find_all_indexes(text, pattern):
    """Return a list of starting indexes of all occurrences of pattern in text,
    or an empty list if not found."""
    assert isinstance(text, str), 'text is not a string: {}'.format(text)
    assert isinstance(pattern, str), 'pattern is not a string: {}'.format(text)
    # TODO: Implement find_all_indexes here (iteratively and/or recursively)


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