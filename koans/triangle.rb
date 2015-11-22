# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
 #handling exception
 unless a+b>c && c+a>b && b+c>a
 	raise TriangleError
 end 		
 
 #returning the type of the triangle
 result = ([a-b, b-c, c-a].select { |x| x == 0 }).length
 if result == 0  
 	:scalene
 elsif result == 1
 	:isosceles
 else
 	:equilateral
 	
 end

end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
