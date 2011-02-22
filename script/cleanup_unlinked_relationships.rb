#!/usr/bin/env ruby
# encoding: utf-8

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

[
  "delete from relationships where id in (select relationships.id from relationships left outer join people on relationships.person_id = people.id where relationships.person_id is not null and people.last_name is null and people.first_name is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join organisations on relationships.organisation_id = organisations.id where relationships.organisation_id is not null and organisations.name is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join productions on relationships.production_id = productions.id where relationships.production_id is not null and productions.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join periodicals on relationships.periodical_id = periodicals.id where relationships.periodical_id is not null and periodicals.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join archive_parts on relationships.archive_part_id = archive_parts.id where relationships.archive_part_id is not null and archive_parts.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join warehouses on relationships.warehouse_id = warehouses.id where relationships.warehouse_id is not null and warehouses.box_location is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join orders on relationships.order_id = orders.id where relationships.order_id is not null and orders.order_number is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join ico_titles on relationships.ico_title_id = ico_titles.id where relationships.ico_title_id is not null and ico_titles.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join genres on relationships.genre_id = genres.id where relationships.genre_id is not null and genres.name_nl is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join venues on relationships.venue_id = venues.id where relationships.venue_id is not null and venues.name is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join functions on relationships.function_id = functions.id where relationships.function_id is not null and functions.name_nl is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join ephemera on relationships.ephemerum_id = ephemera.id where relationships.ephemerum_id is not null and ephemera.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join press_cuttings on relationships.press_cutting_id = press_cuttings.id where relationships.press_cutting_id is not null and press_cuttings.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join languages on relationships.language_id = languages.id where relationships.language_id is not null and languages.iso_code is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join book_titles on relationships.book_title_id = book_titles.id where relationships.book_title_id is not null and book_titles.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join audio_video_titles on relationships.audio_video_title_id = audio_video_titles.id where relationships.audio_video_title_id is not null and audio_video_titles.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join articles on relationships.article_id = articles.id where relationships.article_id is not null and articles.title is null)",
  "delete from relationships where id in (select relationships.id from relationships left outer join donations on relationships.donation_id = donations.id where relationships.donation_id is not null and donations.title is null)"
].each do |query|
  puts ActiveRecord::Base.connection().update_sql query
end