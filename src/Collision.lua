--no collision = 0
--collision top surface of obj2 = 12
--collision right surface of obj2 = 3
--collision bottom surface of obj2 = 6
--collision left surface of obj2 = 9
function collide(obj1,obj2)
    a = 0
    b = 12
    c = 3
    d = 6
    e = 9
    if obj1.x + obj1.width - 2 < obj2.x + 2 or obj2.x + obj2.width - 2 < obj1.x + 2 then
        return a
    elseif obj1.y+ obj1.height - 2 < obj2.y + 2 or obj2.y + obj2.height - 2 < obj1.y + 2 then
        return a
    else
        if obj1.x < obj2.x then
            return e
        elseif obj1.x + obj1.width > obj2.x + obj2.width then
            return c
        elseif obj1.y < obj2.y then
            return b
        else 
            return d
        end
    end
end