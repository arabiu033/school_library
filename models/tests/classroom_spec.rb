require_relative '../student'
require_relative '../classroom'

describe Classroom do
  before(:each) do
    @class = Classroom.new('Class A')
  end

  it 'should print the class name' do
    expect(@class.label).to eql 'Class A'
  end

  it 'should store the student object created' do
    student = Student.new(21, 'Korra', true)
    @class.add_student student
    expect(@class.students[0]).to be student
  end
end
