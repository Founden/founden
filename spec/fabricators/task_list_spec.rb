Fabricator(:task_list, :class_name => TaskList, :from => :attachment) do
  tasks {
    rand(2..5).times.collect do
      {'label' => Faker::Lorem.sentence, 'checked' => [true, false].sample}
    end
  }
end
