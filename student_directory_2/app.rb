# file: app.rb

require_relative './lib/cohort_repository'


DatabaseConnection.connect('student_directory_2_test')

repo = CohortRepository.new
cohort = repo.find_with_students(1)

puts cohort.name 

cohort.students.each do |student|
  puts "* #{student.name}"
end

