class DaysController < ApplicationController

  def welcome
    @welcome_survey = Survey.first
  end

  def one

  end
end