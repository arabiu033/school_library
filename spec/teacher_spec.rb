require_relative '../models/teacher'

describe Teacher do
  before(:each) do
    @teacher = Teacher.new('Ruby', 50, 'Korra')
  end

  it 'should phave access to teacher attributes' do
    expect(@teacher.age).to eql 50
    expect(@teacher.name).to eql 'Korra'
    expect(@teacher.specialization).to eql 'Ruby'
  end

  it 'should return the object state in hash format' do
    teacher = @teacher.to_hash
    expect(teacher[:age]).to eql 50
  end

  it 'should allow teacher to use services' do
    expect(@teacher.can_use_services?).to eql true
  end
end
