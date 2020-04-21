#return true if parenthesis are getting closed
# function will return True if the string expression is correct and False if not. 
# For example, [{1,2,3}, {a,b,c}]  is a valid expression whereas [[{1,2,3] is not
def has_closing_parenthesis(line):
    #best use for stack
    bracket_stack = [] #push and pop at the end
    bracket_dic = {"}":"{", "]":"[", ")":"(" }
    for char in line:
        #if I find an open bracket, push on to stack
        if char in bracket_dic.values():
            bracket_stack.append(char)
        if char in bracket_dic.keys():
            if len(bracket_stack) != 0: #make sure it's not empty
                top = bracket_stack.pop(-1) #peek top which is the last element in the array
                open = bracket_dic[char] #open is the value of the key
                if top == open:
                    bracket_stack.pop(-1) #pop last element
                else: #if not the same then return False
                    return False
    if len(bracket_stack) == 0: #if stack is empty
        return True
    return False

#  "[{1,2,3]}, {a,b,c}"
print(has_closing_parenthesis("{[[1fafs]], []((11))}")) #should return true
print(has_closing_parenthesis("(())[{}]")) #return true
print(has_closing_parenthesis("][")) #return false