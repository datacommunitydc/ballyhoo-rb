# This is definitely overkill for what we're doing, but I wanted to
# introduce the concept and show some basic usage. Normally I wouldn't
# go to this length with the amount of stuff we're doing, but it's a
# good pattern to know and use.

class AnnouncementPresenter < SimpleDelegator
  def display_name
    if announcer_name.present?
      announcer_name
    else
      user.display_name
    end
  end

  def photo
    return default_photo_url unless user
    p = user.primary_photo
    p ? p.url : default_photo_url
  end

  def default_photo_url
    ActionController::Base.helpers.asset_path 'default_photo'
  end
end
