def get_order(tickets):
    #build dic
    from_to_dic = {}
    for ticket in tickets:
        from_island = ticket[0]
        to_island = ticket[1]
        from_to_dic[from_island] = to_island
    #figure where to start, loop through each key and check if it exist in a value
    start = ""
    for from_island in from_to_dic.keys():
        if from_island not in from_to_dic.values():
            start = from_island
    #recontructing the order
    result = []
    current = start
    for _ in range(len(tickets)):
        result.append(current)
        next = from_to_dic[current]
        current = next
    result.append(current)
    return result


print(get_order([("Noodle", "Jungalow"), ("Korok", "Bunpun"), ("Bunpun", "Noodle"), ("Jungalow", "Astra Nova")]))
