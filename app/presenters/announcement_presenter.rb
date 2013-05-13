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
end
