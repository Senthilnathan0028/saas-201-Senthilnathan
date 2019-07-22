require_relative  "./student"
class Department

	attr_accessor :no_students,:a,:b,:c ,:dept_name,:keylist
	def initialize(dept_name)
		
		@dept_name = dept_name
		@a         = Hash.new 
		@b		   = Hash.new
		@c 		   = Hash.new
		@keylist   = { 'A'=> self.a , 'B' => self.b , 'C' => self.c }
		@no_students=0
	end

	def add_st student_name,section
		temp =self.keylist[section]
		temp[student_name]=(Student.new student_name,0,section,self.dept_name)
		temp =sort temp
		#i=1
		#temp = temp.each_value { |e| e.roll_no = i ;i=i+1;}
		#puts temp
		point temp,section
		self.no_students = self.a.length+self.b.length+self.c.length
		self

		#puts temp
	end

	def point key,section
		if section=='A'
			self.a=key
		elsif section=='B'
			self.b=key
		else
			self.c=key
		end
		self.keylist   = { 'A'=> self.a , 'B' => self.b , 'C' => self.c }
	end
	def sort temp
		temp =temp.sort_by { |key| key }.to_h
		i=1
		temp = temp.each_value { |e| e.roll_no = i ;i=i+1;}
		#puts temp
		temp
	end

	def remove student_name,section
		
		sec_keylist =self.keylist[section]
		sec_keylist.delete(student_name)
		sec_keylist =sort sec_keylist
		point sec_keylist,section
		self.no_students = self.a.size+self.b.size+self.c.size
		return true
	end

end
