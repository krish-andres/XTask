require_relative '../spec_helper.rb'

describe XTask::Task do 
  let(:task){ XTask::Task.new({
    name: 'task_1',
    monday: true,
    tuesday: false,
    wednesday: false,
    thursday: false,
    friday: false,
    saturday: false,
    sunday: false,
    start_time: '12:00 am',
    end_time: '1:00 pm',
    type: 'Project'
    }) 
  }

  describe 'Task' do
    it 'initializes a task' do
      expect(task).to be_a(XTask::Task)
      expect(task.monday).to eq(true)
      expect(task.tuesday).to eq(false)
      expect(task.name).to eq('task_1')
    end  
  end  
end  
