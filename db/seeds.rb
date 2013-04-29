# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user = User.create({email: "allan@enspiral.com", password: "password", password_confirmation: "password"})
@yesterday = Day.create({date: Date.today - 1.days})
@yesterday.save!
@user.days << @yesterday
@user.save!


@user.metrics << Metric.create({name: "Pushups AM", score_type: "big_number"})
@user.metrics << Metric.create({name: "Did its", score_type: "boolean"})

@user.metrics.each do |m|
  @yesterday.metric_scores << MetricScore.create({day: @yesterday, metric: m, score: 1})
end
@yesterday.save!
