require 'zip'

module OpenProject
  module Export
    class AttachmentsController < ::ApplicationController
      before_action :find_project, :authorize

      def download_all
        send_data zipped_attachments,
                  type: 'application/zip',
                  filename: "#{@project.identifier}-attachments.zip"
      end

      private

      def find_project
        @project = Project.find(params[:project_id])
      end

      def zipped_attachments
        buffer = Zip::OutputStream.write_buffer do |zip|
          @project.attachments.each do |attachment|
            next unless attachment.file.present?
            zip.put_next_entry(attachment.filename)
            zip.write attachment.diskfile.binread
          end
        end
        buffer.rewind
        buffer.read
      end
    end
  end
end
