class GroupsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    if @group.question_id.nil?
      @group.question_id = @group.topic.questions.first.id
      @group.save
    end
  end

  def play
    @group = Group.find(params[:group_id])
  end

  def next_question
    group = Group.find(params[:group_id])
    question = group.topic.questions.where("id > " + group.question_id.to_s).first
    if question.nil?
      question = group.topic.questions.first
    end
    render :partial => "groups/single_question", :locals => { :question => question }, :status => 200
    group.update_attributes(:question_id => question.id, :question_time => Time.current)
  end

  def submit
    group = Group.find(params[:group_id])
    question = Question.find(params[:question_id])
    answer_index = params[:answer_index].to_i
    if !group.topic.questions[answer_index].nil? && question.answer_id == group.topic.questions[answer_index].id
      correct = true
    else
      correct = false
    end
    #add submission?
    Pusher['presence-group-1'].trigger('new_submission', {
      :correct => correct,
      :user_id => current_user.id
    })
    render :json => correct, :status => 200
  end
end
