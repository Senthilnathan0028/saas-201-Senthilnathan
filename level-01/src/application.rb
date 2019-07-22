require_relative './department' # Include other files in the same directory
require "set"
# Your application
class Application
   attr_accessor :departments

  def initialize
  	@departments = Hash.new
    ['EEE', 'MECH', 'CSE', 'CIVIL'].each { |dept| self.departments[dept]= Department.new dept }
  end

  def enroll(student_name, student_department)
    # This is a sample implementation. you can write your own code
    # department.enroll student_name
   
  	if((ind_dept student_department) && (self.departments[student_department].no_students < 30) && student_name.length>0 )
  		
  		section = add_to_section student_name,student_department
  		st_object = find_student student_name
  	    success student_department,section,st_object.roll_no
  	
  	else

    		if student_name.length==0||!(ind_dept student_department) 
          "Error: Provide a valid input"
        else
          "Error: Seats are Full"
        end
    end

	end


  def change_dept(student_name, student_department)
    ## write some logic to frame the string below
  	if((ind_dept student_department) && (self.departments[student_department].no_students < 30) && student_name.length>0 )
    		student_object = find_student(student_name)
    		
    		if student_object!=-1
    			delete_from_department = student_object.dept_name
    			delete_from_section    = student_object.section
          if(delete_from_department==student_department)
            "Error: You are already in the department...Don't worry "
          else  
    			  self.departments[delete_from_department].remove student_name,delete_from_section
    		  	enroll student_name,student_department
          end
    		else
    			"Error: Provide a valid name"
    		end
  	else
    		if student_name.length==0||!(ind_dept student_department) 
          "Error: Provide a valid input"
        else
          "Error: Seats are Full"
        end
  	end
  
  end

  def change_section(student_name, section)
    ## write some logic to frame the string below
      student_object = find_student(student_name)
      if student_object!=nil&&student_object!=-1
        	student_department = student_object.dept_name
    		  delete_from_section    = student_object.section
    		  keylist = self.departments[student_department].keylist
    		  add_sec_keylist = keylist[section]
    	   	if add_sec_keylist!=nil&&add_sec_keylist.length<10
        			self.departments[student_department].remove student_name,delete_from_section
        			dept=self.departments[student_department]        
              if(delete_from_section==section)
                "Error: You are already in that section...Don't worry "
              else  
            		dept.add_st student_name,section
            		self.departments[student_department]=dept
            		student_object = find_student student_name
          	   	extra=''
          			if student_object.roll_no<10
          				extra='0'
          			end
        			  "You have been allotted section #{section}" \
       		   	   "\nYour roll number is "+"#{student_object.dept_name}"[0..2]+"#{section}#{extra}#{student_object.roll_no}\n"
              end
    		  else
    		  	if add_sec_keylist==nil || student_name.length==0
              "Error: Please provide a valid input"
            else
              "Error: Seats are full"
    	     	end
          end
  	  else
  		    "Error: Provide a valid name"
  	  end

    end

  def puts_dep_sec_student student_object
  	if student_object!=nil
	    extra = ''
		if student_object.roll_no<10
			extra='0'
		end
		return ("#{student_object.student_name}"+" - "+"#{student_object.dept_name}"[0..2]+"#{student_object.section}#{extra}#{student_object.roll_no}")
	end
  end
  def department_view(student_department)
  
    if((ind_dept student_department)  )  
    	temp=''
    	if (self.departments[student_department].no_students)>0
    		temp+="List of students:" 
    	end
    	
    	keylist = self.departments[student_department].keylist
    	keylist.each_key { |section|
    		sec_key=keylist[section]
    		sec_key.each_value { |student_object|
    			temp =temp+"\n"
    			temp = temp + (puts_dep_sec_student student_object)
    		} 
    	 }
    	 temp
    	
    else
    	"Error: Please provide a valid department"
    end
  end

  def section_view(student_department, section)
    ## write some logic to frame the string below
    if((ind_dept student_department)  )   
    	keylist = self.departments[student_department].keylist
    	sec_key = keylist[section]
    	temp =''
    	if sec_key!=nil
    		 temp = temp+"List of students:"
    		sec_key.each_value { |student_object|
    			temp = temp+"\n"
    			temp =temp + (puts_dep_sec_student student_object)
    		} 
    	else
    		 "Error: Please provide a valid section"
    	end
    	 if(temp=='')
        "Error: Please provide a valid section"
      else
        temp
      end
    	
    else
    	 "Error: Please provide a valid department"
    end

  end

  def student_details(student_name)
    
    st = find_student student_name
    if st!=-1
    	extra=''
		if st.roll_no<10
			extra='0'
		end
		temp = "#{st.student_name} - #{st.dept_name} - Section #{st.section} - "+"#{st.dept_name}"[0..2]+"#{st.section}#{extra}#{st.roll_no}"
 		return temp.chomp 
 	else
 		 "Error: Please provide a valid input"
 	end
  end


  def add_to_section student_name,student_department

  	dept = self.departments[student_department]
  	if (dept.a).length<10
  		dept=dept.add_st student_name,'A'
  		section='A'
  	elsif dept.b.length<10
  		dept=dept.add_st student_name,'B'
  		section='B'
  	else 
		 dept=dept.add_st student_name,'C'
		section='C'
	end
	self.departments[student_department]=dept
	return section

  end 


  def ind_dept(student_dept)
  	
  	self.departments.include?student_dept

  end

  def find_student student_name

  		(self.departments).each_value { |dept| 
  			
  			keylist = dept.keylist
  			['A','B','C'].each { |section| 
  				sec_key=keylist[section]
				student =sec_key[student_name]
				if student!=nil
					return student 
				end
  			 }
  		}

  		return -1
	  	
  end

  def success student_department,section,roll_no 
  	extra=''
	if roll_no<10
		extra='0'
	end
  	return "You have been enrolled to #{student_department}" \
	    "\nYou have been allotted section #{section}" \
	    "\nYour roll number is "+"#{student_department}"[0..2]+"#{section}#{extra}#{roll_no}"
  end 

 
end