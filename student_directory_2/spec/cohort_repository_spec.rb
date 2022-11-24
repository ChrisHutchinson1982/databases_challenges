require 'cohort_repository'

RSpec.describe CohortRepository do
  def reset_students_table
    seed_sql = File.read('spec/seeds_student_directory_2.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
    connection.exec(seed_sql)
  end
  
  describe CohortRepository do
    before(:each) do 
      reset_students_table
    end
    

    it 'Find cohort 1 with related students' do
      repo = CohortRepository.new
      cohort = repo.find_with_students(1)
      expect(cohort.name).to eq'Cohort 1'
      expect(cohort.students.length).to eq 3
      expect(cohort.students[0].name).to eq 'Name 1'
    end

  end

end