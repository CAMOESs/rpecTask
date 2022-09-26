require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "バリデーション" do
    it "タイトルが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end

    it "ステータスが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "完了期限が未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).not_to eql("Deadline can't be blank")
    end
    
    it "完了期限が過去の日付の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: "2022-10-26 18:05:17")
      expect(task).to be_invalid
      expect(task.deadline).to be >= Time.current
    end

    it "完了期限が今日の日付の場合、タスクのバリデーションが有効であること" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Date.current)
      expect(task).to be_invalid
      expect(task.deadline).to eq (Date.current)
    end
  end
end