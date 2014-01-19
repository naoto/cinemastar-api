# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Quarter.create([{ name: '冬' },
                { name: '春' },
                { name: '夏' },
                { name: '秋' }])

AdminUser.create(email: 'admin@example.com', password: 'administrator', password_confirmation: 'administrator')
