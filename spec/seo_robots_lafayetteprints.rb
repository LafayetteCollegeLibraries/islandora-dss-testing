require "robotstxt"

describe "robots.txt restrictions for web crawlers" do

  it 'prevents /cas from being crawled' do

    expect(Robotstxt.allowed? 'http://digital.stage.lafayette.edu/cas', 'stage').to be_false
    expect(Robotstxt.allowed? 'http://digital.stage.lafayette.edu/cas?destination=node/27%3F', 'stage').to be_false
  end

  it 'prevents /collections/browse?f[0]* from being crawled' do

    expect(Robotstxt.allowed? 'http://digital.stage.lafayette.edu/collections/browse?f[0]=mdl_prints.description.series:%22Portraits:%20Before%201789%22', 'stage').to be_false
  end

  it 'prevents /islandora/search from being crawled' do

    expect(Robotstxt.allowed? 'http://digital.stage.lafayette.edu/islandora/search/dc.title:(test)', 'stage').to be_false
  end

  it 'prevents /islandora/search from being crawled' do

    expect(Robotstxt.allowed? 'http://digital.stage.lafayette.edu/islandora/search/dc.title:(test)', 'stage').to be_false
  end

  it 'permits faceted "series" within the Marquis de Lafayette Prints Collection to be crawled' do

    expect(Robotstxt.allowed?('http://digital.stage.lafayette.edu/islandora/search/*:*?f[0]=cdm.Relation.IsPartOf:%22Marquis%20de%20Lafayette%20Prints%20Collection%22&f[1]=mdl_prints.description.series:%22Portraits:%20Before%201789%22', 'stage')).to be_true
  end
end
