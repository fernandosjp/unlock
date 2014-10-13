json.id @initiative.id
json.permalink @initiative.permalink
json.name @initiative.name
json.user do
  json.id @initiative.user.id
  json.name @initiative.user.name
end
json.image (@initiative.image.present? ? @initiative.image.url : nil)
json.first_text @initiative.first_text
json.second_text @initiative.second_text
if policy(@initiative).update?
  json.moip_token @initiative.moip_token
  json.moip_key @initiative.moip_key
  json.sandbox @initiative.sandbox
end
json.total_value @initiative.total_value
json.total_contributions @initiative.total_contributions
json.created_at @initiative.created_at
json.updated_at @initiative.updated_at
