class StaticPagesController < ApplicationController
  def home


  	Rails.logger.info "TIME NOW #{Time.now}"
  	scheduler = Rufus::Scheduler.new
  	Rails.logger.info "TIME NOW #{scheduler}"

  	scheduler.in '5s' do
      Rails.logger.info "TIME NOW #{Time.now}"
    end

  end

  def help
  end

  def about

  end

  private

 
end
