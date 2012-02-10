class SubmissionsController < ApplicationController
  def add
    page = Page.find(params[:page_id].to_i)
    correct = 0
    page.questions.each do |question|
      submission = Submission.create(
        :page_id => page.id,
        :question_id => question.id,
        :user_id => current_user.id,
        :answer_id => params[:answers][question.id.to_s]
      )
      if question.answer_id == submission.answer_id
        correct = correct + 1
      end
    end

    taker = Taker.find_by_user_id_and_page_id(current_user.id, page.id)
    if correct == page.questions.size
      render_text = "You got 100%"
      taker.status = 2
      message_body = current_user.name + " got 100%"
      message = Message.create(:body => message_body, :page_id => page.id);
    else
      render_text = "You got " + correct.to_s + " out of " + page.questions.size.to_s
      taker.status = 1
      message_body = current_user.name + " is done"
      message = Message.create(:body => message_body, :page_id => page.id);
    end
    taker.save

    message_html = render_to_string(:partial => "messages/announcement", :locals => { :message => message })
    Pusher['page-' + params[:page_id]].trigger('add_message', {
      :message_html => message_html
    })

    user_html = render_to_string(:partial => "pages/user", :locals => { :user => current_user })
    Pusher['page-' + params[:page_id]].trigger('update_user', {
      :user_id => current_user.id,
      :user_html => user_html
    })

    render :text => render_text, :status => 200
    #update taker status on pages
  end
end
