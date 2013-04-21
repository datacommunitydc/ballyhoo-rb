namespace :db do 
    desc "Fill database with sample data"
    task populate: :environment do 
        make_meetups
        make_users
        make_announcements
    end
end

def make_meetups
    # four meetups, in each combo of the two permissions settings
    # name, :url_name, :announcements_enabled, :anon_view_enabled, :photo_url
    Meetup.create!(name:"Data Science DC", url_name:"Data-Science-DC", 
        photo_url:"http://photos2.meetupstatic.com/photos/event/c/5/a/a/event_218450602.jpeg",
        announcements_enabled: true, anon_view_enabled:true)
    Meetup.create!(name:"Data Science MD", url_name:"Data-Science-MD", 
        photo_url:"http://photos4.meetupstatic.com/photos/event/5/f/0/2/event_214164322.jpeg",
        announcements_enabled: true, anon_view_enabled:false)
    Meetup.create!(name:"DC Ruby Users Group", url_name:"dcrug.org", 
        photo_url:"http://photos3.meetupstatic.com/photos/event/8/3/b/d/event_7533725.jpeg",
        announcements_enabled: false, anon_view_enabled:true)
    Meetup.create!(name:"No Logo DC", url_name:"No-Logo-DC", 
        photo_url:nil,
        announcements_enabled: false, anon_view_enabled:false)
end
def make_users
    # user 1 = normal for all four Meetups
    # user 2 = admin for all four Meetups
    # user 3 = normal for #1, admin for #2
    # user 4 = member of no meetups
    u_normal = User.create(email: 'normal@example.com', meetups: Meetup.all)
    u_damare = User.create(email: 'damare@example.com', meetups: Meetup.all, admin:true)
    u_special = User.create(email: 'special@example.com', meetups: Meetup.all[0..1])
    # flip admin bit?
    u_nobody = User.create(email: 'nobody@example.com')
end

def make_announcements
    # users = User.all 
    # user = users.first
    # followed_users = users[2..50]
    # followers = users[3..40]
    # followed_users.each { |followed| user.follow!(followed) }
    # followers.each { |follower| follower.follow!(user) }
end
