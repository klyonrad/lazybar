# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

IngredientCategory.create([
                            { name: 'London Dry Gin' }, # 1
                            { name: 'Liqueur' },
                            { name: 'Cachaça' },
                            { name: 'Tequila white' },
                            { name: 'Tequila Reposado' },
                            { name: 'Tequila Añejo' }, # 5
                            { name: 'White Rum' },
                            { name: 'Dark Rum' },
                            { name: 'Tonic Water' },
                            { name: 'Vermouth Red' }, # 10
                            { name: 'Vermouth Dry' },
                            { name: 'Juice' },
                            { name: 'Ginger Beer' },
                            { name: 'Sirup' },
                            { name: 'Rye Whiskey' }, # 15
                            { name: 'Scotch Whisky' },
                            { name: 'Bourbon Whiskey' },
                            { name: 'Corn Whiskey' },
                            { name: 'Islay Scotch Whisky' },
                            { name: 'Bitter' }, # 20
                            { name: 'Absinth' },
                            { name: 'Vodka' },
                            { name: 'Other' }
                          ])

def category name
  IngredientCategory.find_by_name name
end
Ingredient.create!([
                    { name: 'Monkey 47', price_per_cl: 0.64, ingredient_category: category('London Dry Gin') },
                    { name: 'Bombay Saphire 37%', price_per_cl: 0.22, ingredient_category: category('London Dry Gin'), comment: 'blaue Flasche' },
                    { name: 'Tanqueray', price_per_cl: 0.22, ingredient_category: category('London Dry Gin') },
                    { name: 'Finsbury Platinum Dry', price_per_cl: 0.22, ingredient_category: category('London Dry Gin') },
                    { name: "Hendrick's", price_per_cl: 0.30, ingredient_category: category('London Dry Gin'), available: false, comment: 'Preis unbestimmt' },
                    { name: 'Tanqueray N° Ten', price_per_cl: 0.356, ingredient_category: category('London Dry Gin') },
                    { name: 'Beefeater', price_per_cl: 0.256, ingredient_category: category('London Dry Gin'), comment: nil },
                    { name: 'Brugal Ron Blanco Especial', price_per_cl: 0.19, ingredient_category: category('White Rum') },
                    { name: "Gosling's Black Seal", price_per_cl: 0.29, ingredient_category: category('Dark Rum'), comment: nil },
                    { name: 'Ron Mulata', price_per_cl: 0.2, ingredient_category: category('Dark Rum') },
                    { name: 'Appleton White', price_per_cl: 0.19, ingredient_category: category('White Rum') },
                    { name: 'Appleton Estate V/X', price_per_cl: 0.236, ingredient_category: category('Dark Rum') },
                    { name: 'Brugal Ron Reserva XV', price_per_cl: 0.31, ingredient_category: category('Dark Rum') },
                    { name: 'Chartreuse Verte', price_per_cl: 0.39, ingredient_category: category('Liqueur'), comment: 'Der knallt. Und ist lecker.' },
                    { name: 'Chartreuse Jaune', price_per_cl: 0, ingredient_category: category('Liqueur'), available: false },
                    { name: 'Bénedictine D.O.M.', price_per_cl: 0.3, ingredient_category: category('Liqueur') },
                    { name: 'Heering Cherry', price_per_cl: 0.24, ingredient_category: category('Liqueur') },
                    { name: 'Galliano Authentico', price_per_cl: 0.2, ingredient_category: category('Liqueur') },
                    { name: 'St Germain', price_per_cl: 0.38, ingredient_category: category('Liqueur') },
                    { name: 'Monkey Shoulder', price_per_cl: 0.35, ingredient_category: category('Scotch Whisky') },
                    { name: 'Campari', price_per_cl: 0.13, ingredient_category: category('Liqueur') },
                    { name: 'Martini Rosso', price_per_cl: 0.09, ingredient_category: category('Vermouth Red') },
                    { name: 'Martini Extra Dry', price_per_cl: 0.09, ingredient_category: category('Vermouth Dry') },
                    { name: 'Johnnie Walker Black Label', price_per_cl: 0.38, ingredient_category: category('Scotch Whisky') },
                    { name: 'Cointreau', price_per_cl: 0.2195, ingredient_category: category('Liqueur') },
                    { name: 'Vodka Gorbatschow Citron', price_per_cl: 0.11, ingredient_category: category('Vodka') },
                    { name: 'Sierra Tequila Silver', price_per_cl: 0.18, ingredient_category: category('Tequila white') },
                    { name: 'Sauza Hornitos Reposado', price_per_cl: 0.31, ingredient_category: category('Tequila Reposado') },
                    { name: 'Don Julio Reposado', price_per_cl: 0.58, ingredient_category: category('Tequila Reposado'), comment: nil },
                    { name: 'El Tesoro Reposado', price_per_cl: 0.65, ingredient_category: category('Tequila Reposado') },
                    { name: 'Cachaça século xviii', price_per_cl: 0.4, ingredient_category: category('Cachaça') },
                    { name: 'Limettensaft', price_per_cl: 0.25, ingredient_category: category('Juice') },
                    { name: 'Zitronensaft', price_per_cl: 0.1, ingredient_category: category('Juice') },
                    { name: "Lime Juice Cordial (Rose's)", price_per_cl: 0.04, ingredient_category: category('Juice') },
                    { name: 'Cranberrynektar', price_per_cl: 0.04, ingredient_category: category('Juice') },
                    { name: 'Orangensaft (Flasche)', price_per_cl: 0.01, ingredient_category: category('Juice') },
                    { name: 'Ananassaft', price_per_cl: 0.05, ingredient_category: category('Juice') },
                    { name: "Gosling's Ginger Beer", price_per_cl: 0.05, ingredient_category: category('Ginger Beer') },
                    { name: 'Old Jamaican Ginger Beer', price_per_cl: 0.03, ingredient_category: category('Ginger Beer') },
                    { name: 'FeverTree Mediterranean', price_per_cl: 0.075, ingredient_category: category('Tonic Water'), comment: nil },
                    { name: 'Orangensaft (frisch gepresst)', price_per_cl: 0.1, ingredient_category: category('Juice') },
                    { name: 'Blutorangensaft', price_per_cl: 0.07, ingredient_category: category('Juice') },
                    { name: 'Grenadine', price_per_cl: 0.086, ingredient_category: category('Sirup') },
                    { name: 'Maracuja Sirup', price_per_cl: 0.09, ingredient_category: category('Sirup') },
                    { name: 'Mandel Sirup', price_per_cl: 0.09, ingredient_category: category('Sirup') },
                    { name: 'Belsazar Vermouth Rose', price_per_cl: 0.186, ingredient_category: category('Vermouth Red') },
                    { name: 'Cachaça Rega Fuelo', price_per_cl: 0.2, ingredient_category: category('Cachaça') },
                    { name: 'Thomas Henry (bigBottle)', price_per_cl: 0.02, ingredient_category: category('Tonic Water') },
                    { name: 'Luxardo Maraschino', price_per_cl: 0.256, ingredient_category: category('Liqueur') },
                    { name: 'Cachaça João Mendes Prata', price_per_cl: 0.172, ingredient_category: category('Cachaça') },
                    { name: 'Cachaça Vale Verde Prata', price_per_cl: 0.214, ingredient_category: category('Cachaça') },
                    { name: 'Bullet Rye', price_per_cl: 0.286, ingredient_category: category('Rye Whiskey') },
                    { name: 'Creme Violet', price_per_cl: 0.3574, ingredient_category: category('Liqueur') },
                    { name: 'Mellow Corn', price_per_cl: 0.3222, ingredient_category: category('Corn Whiskey') },
                    { name: "Maker's Mark", price_per_cl: 0.3379, ingredient_category: category('Bourbon Whiskey') },
                    { name: 'Laphroaig', price_per_cl: 0.4986, ingredient_category: category('Islay Scotch Whisky') },
                    { name: "Peychaud's Bitters", price_per_cl: 1.29, ingredient_category: category('Bitter') },
                    { name: 'Drambuie', price_per_cl: 0.3, ingredient_category: category('Liqueur') },
                    { name: 'Tabu Absinth', price_per_cl: 0.639, ingredient_category: category('Absinth') }
                  ])

def ingredient(name)
  Ingredient.find_by_name(name)
end

CocktailRecipe.create([
                        { name: 'Gin & Tonic', cocktail_recipe_parts:
                                [
                                  CocktailRecipePart.new(ingredient: ingredient('Finsbury Platinum Dry'),
                                                         ingredient_category: ingredient('Finsbury Platinum Dry').ingredient_category,
                                                         amount: 50),
                                  CocktailRecipePart.new(ingredient: ingredient('FeverTree Mediterranean'),
                                                         ingredient_category: ingredient('FeverTree Mediterranean').ingredient_category,
                                                         amount: 100)
                                ] },
                        { name: 'Negroni', cocktail_recipe_parts:
                                [
                                  CocktailRecipePart.new(ingredient: ingredient('Bombay Saphire 37%'),
                                                         ingredient_category: ingredient('Bombay Saphire 37%').ingredient_category,
                                                         amount: 40),
                                  CocktailRecipePart.new(ingredient: ingredient('Campari'),
                                                         strict: true,
                                                         ingredient_category: ingredient('Campari').ingredient_category,
                                                         amount: 40),
                                  CocktailRecipePart.new(ingredient: ingredient('Martini Rosso'),
                                                         ingredient_category: ingredient('Martini Rosso').ingredient_category,
                                                         amount: 40)
                                ] }
                      ])
