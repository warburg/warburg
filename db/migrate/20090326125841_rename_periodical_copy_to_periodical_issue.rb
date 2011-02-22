class RenamePeriodicalCopyToPeriodicalIssue < ActiveRecord::Migration
  def self.up
    rename_table :periodical_copies, :periodical_issues
    rename_column :periodical_issues, :part_of_copy_id, :part_of_issue_id
    rename_column :articles, :periodical_copy_id, :periodical_issue_id
    rename_column :periodical_issues, :copy_id, :issue_id
  end

  def self.down
    rename_column :periodical_issues, :issue_id, :copy_id
    rename_column :articles, :periodical_issue_id, :periodical_copy_id
    rename_column :periodical_issues, :part_of_issue_id, :part_of_copy_id
    rename_table :periodical_issues, :periodical_copies
  end
end
