json.array!(@survey_responses) do |survey_response|
  json.extract! survey_response, 
  json.url survey_response_url(survey_response, format: :json)
end