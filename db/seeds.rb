# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

IngredientCategory.create([
                            { name: 'London Dry Gin' },
                            { name: 'Liqueur' },
                            { name: 'Cachaça' },
                            { name: 'Tequila' },
                            { name: 'White Rum' },
                            { name: 'Dark Rum' }
                          ])

Ingredient.create([
                    { name: 'Bombay Sapphire', price_per_cl: 0.22, ingredient_category_id: 1, comment: 'blaue Flasche' },
                    { name: 'Beefeater', price_per_cl: 0.256, ingredient_category_id: 1, comment: nil },
                    { name: 'Chartreuse Verte', price_per_cl: 0.39, ingredient_category_id: 2, comment: 'Der knallt. Und ist lecker.' },
                    { name: "Gosling's Black Seal", price_per_cl: 0.29, ingredient_category_id: 6, comment: nil },
                    { name: 'Don Julio Reposado', price_per_cl: 0.58, ingredient_category_id: 4, comment: nil }
                  ])