{
  queued: @announcements.queued,
  visible: @announcements.visible,
  archived: @announcements.archived
}.each_pair do |key, set|
  json.set! key do
    json.array! set do |ann|
      json.partial! ann
    end
  end
end
