require_relative '../student'
require_relative '../classroom'

describe Student do
  before(:each) do
    @student = Student.new(21, 'Korra', true)
  end

  it 'should print the hookey song' do
    expect(@student.play_hooky).to eql '¯(ツ)/¯'
  end

  it 'should return the object state in hash format' do
    stu = @student.to_hash
    expect(stu[:age]).to eql 21
  end

  it 'should allow class objects to be added' do
    clas = Classroom.new('Class A')
    @student.classroom = clas
    expect(@student.classroom).to eql clas
  end
end