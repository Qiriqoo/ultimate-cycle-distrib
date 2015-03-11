Paperclip::Attachment.default_options[:path] = '/:class/:id/:style/:basename.:extension'
Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:default_url] = '/attachment/default.jpg'

Spree::Image.attachment_definitions[:attachment][:path] = '/:class/:id/:style/:basename.:extension'
Spree::Image.attachment_definitions[:attachment][:url] = ':s3_domain_url'
Spree::Image.attachment_definitions[:attachment][:default_url] = '/attachment/default.jpg'
