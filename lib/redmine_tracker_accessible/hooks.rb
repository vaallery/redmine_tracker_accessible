module RedmineTrackerAccessible
  class Hooks < Redmine::Hook::ViewListener

    include IssuesControllerPatch::InstanceMethods

    def view_issues_form_details_top(context={})
      @issue = context[:issue]
      @project = context[:project]
      tracker_ids = tracker_accessible_allowed_tracker_ids
      @allowed_trackers = Tracker.where(:id => tracker_ids).order("#{Tracker.table_name}.position")

      "<script type='text/javascript'>
        $('select#issue_tracker_id').ready(function() {
          $('select#issue_tracker_id').html('#{escape_javascript(options_for_select(@allowed_trackers.collect { |t| [t.name, t.id] }))}')
        })
      </script>"
    end

  end

end