require_relative '../helpers/capybara_helper'

class GoogleNewsPage
  include Capybara::DSL

  PAGE_URL = 'https://news.google.co.uk'
  CATEGORIES_COUNT = 2
  STORIES_PER_CATEGORY_COUNT = 3

  def initialize
    puts "Open news url: #{PAGE_URL}"
    visit PAGE_URL
  end

  def news
    puts "Get news: #{PAGE_URL}"
    sections.inject({}) do |result, section_container|
      result.tap do |categories|
        categories[category_name(section_container)] = stories(section_container).map do |story_container|
          { id:     story_container[:cid],
            title:  story_container.find(:css, '.titletext').text,
            teaser: story_container.find(:css, '.esc-lead-snippet-wrapper').text
          }.tap do |story|
            if story_container.first(:css, '.esc-layout-thumbnail-cell')
              story[:img] = story_container.find(:css, '.esc-thumbnail-image')[:src]
            end
          end
        end
      end
    end
  end

  private
  def sections
    all(:css, '.section-list .section', visible: true).map {|el| el}.shuffle.first(CATEGORIES_COUNT)
  end

  def stories(container)
    container.all(:css, '.story.esc').first(STORIES_PER_CATEGORY_COUNT)
  end

  def category_name(container)
    container.find(:css, '.section-name').text.gsub(/[^\w]/, '').downcase.to_sym
  end
end