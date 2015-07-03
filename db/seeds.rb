# Set Up Store Configuration
Spree::Store.new do |s|
  s.code              = 'UCD'
  s.name              = 'Ultimate Cycle Distribution'
  s.url               = 'ultimate-cycle-distribution.fr'
  s.mail_from_address = 'support@ultimate-cycle-distribution.fr'
  s.default_currency = 'EUR'
  s.default = true
end.save!

# Create Roles
['admin', 'subadmin'].each do |role|
  Spree::Role.where(name: role).first_or_create
end

Spree::Page.create!(name: 'Conditions Generales de Ventes', slug: 'conditions-generales-de-ventes', content: 'Conditions générales de ventes')
Spree::Page.create!(name: 'Mentions legales', slug: 'mentions-legales', content: 'Mentions légales')

# Create France country
france = Spree::Country.create!(name: "France", iso3: "FRA", iso: "FR", iso_name: "FRANCE", numcode: "250")

# Create related states of France
Spree::State.create!([
  { name: 'Alsace', abbr: 'ALS', country_id: france.id },
  { name: 'Aquitaine', abbr: 'AQT', country_id: france.id },
  { name: 'Auvergne', abbr: 'AUV', country_id: france.id },
  { name: 'Bourgogne', abbr: 'BUR', country_id: france.id },
  { name: 'Bretagne', abbr: 'BRT', country_id: france.id },
  { name: 'Centre', abbr: 'CEN', country_id: france.id },
  { name: 'Champagne-Ardenne', abbr: 'CA', country_id: france.id },
  { name: 'Corse', abbr: 'CRS', country_id: france.id },
  { name: 'Franche-Comté', abbr: 'FC', country_id: france.id },
  { name: 'Île-de-France', abbr: 'IDF', country_id: france.id },
  { name: 'Languedoc-Roussillon', abbr: 'LDR', country_id: france.id },
  { name: 'Limousin', abbr: 'LIM', country_id: france.id },
  { name: 'Lorraine', abbr: 'LOR', country_id: france.id },
  { name: 'Midi-Pyrénées', abbr: 'MDP', country_id: france.id },
  { name: 'Nord-Pas-de-Calais', abbr: 'NPC', country_id: france.id },
  { name: 'Basse Normandie', abbr: 'BND', country_id: france.id },
  { name: 'Haute Normandie', abbr: 'HND', country_id: france.id },
  { name: 'Pays de la Loire', abbr: 'PDL', country_id: france.id },
  { name: 'Picardie', abbr: 'PIC', country_id: france.id },
  { name: 'Poitou-Charentes', abbr: 'POI', country_id: france.id },
  { name: "Provence-Alpes-Côte d'Azur", abbr: 'PACA', country_id: france.id },
  { name: 'Rhône-Alpes', abbr: 'RA', country_id: france.id },
  { name: 'Guadeloupe', abbr: 'GLP', country_id: france.id },
  { name: 'Guyane', abbr: 'GUF', country_id: france.id },
  { name: 'Martinique', abbr: 'MTQ', country_id: france.id },
  { name: 'Mayotte', abbr: 'MYT', country_id: france.id },
  { name: 'La Réunion', abbr: 'REU', country_id: france.id }
])
