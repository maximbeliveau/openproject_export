require "zip"
class AttachmentsExportController < ApplicationController
  before_action :find_project_by_project_id
  before_action :authorize

  def download
    attachments = Attachment.where(project_id: @project.id)

    zip_data = Zip::OutputStream.write_buffer do |zip|
      attachments.each do |att|
        next unless att.file&.exists?
        zip.put_next_entry(att.filename)
        zip.write File.binread(att.diskfile)
      end
    end

    send_data zip_data.string,
              type: 'application/zip',
              filename: "#{@project.identifier}-attachments.zip"
  end
end
